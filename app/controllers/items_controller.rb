require 'will_paginate/array'
class ItemsController < ApplicationController
  before_filter :get_item

  def get_item
    @item = Item.first
    if @item.nil?
      @item = Item.new
      @item.description = 'first'
      @item.pn = 'test'
      @item.org_sn = '1234'
      @item.cal_cycle_days = 365
      @item.last_calibrated_on = Time.now
      @item.save
    end

  end
  # GET /items
  # GET /items.xml
  def index
    @items = Item.due_cal.paginate :page => params[:page], :per_page => 10
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @items }
    end
  end

  # GET /items/1
  # GET /items/1.xml
  def show
    @item = Item.find(params[:id])
    @issues = @item.issues.all(:order => 'created_at DESC')
    @dependents = @item.dependents.all( :order => 'created_at DESC')
    @event = @item.events.first( :order => 'created_at DESC' )
    @documents = @item.external_docs.all( :order => 'created_at DESC')
    @cost = @item.events.sum( :cost, :conditions => ["created_at > ?", 1.year.ago] ).to_f
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @item }
    end
  end

  # GET /items/new
  # GET /items/new.xml
  def new
    @item = Item.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @item }
    end
  end

  # GET /items/1/edit
  def edit
    @item = Item.find(params[:id])
  end

  # POST /items
  # POST /items.xml
  def create
    @item = Item.create(params[:item])

    respond_to do |format|
      if @item.save
        flash[:notice] = 'Item was successfully created.'
        format.html { redirect_to(@item) }
        format.xml  { render :xml => @item, :status => :created, :location => @item }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @item.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /items/1
  # PUT /items/1.xml
  def update
    @item = Item.find(params[:id])

    respond_to do |format|
      if @item.update_attributes(params[:item])
        flash[:notice] = 'Item was successfully updated.'
        format.html { redirect_to(@item) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @item.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /items/1
  # DELETE /items/1.xml
  def destroy
    puts "in destroy"
    @item = Item.find(params[:id])
    @item.destroy

    respond_to do |format|
      format.html { redirect_to(items_url) }
      format.xml  { head :ok }
    end
  end

  #testing method to load 500 items into the database
  #no pictures are loaded - might be a good addition
  #to be removed or moved to a seed section
  def test_loader( number_of_records )
    number_of_records = 1000 if number_of_records > 1000
  	for i in ( 1..number_of_records )
	  	item = Item.new
		  item.description = 'test-' + i.to_s
		  item.mfgr = 'test'
      item.pn = '1234'
      item.org_sn = '123'
      item.cal_cycle_days = '365'
		  some_days = rand(500)
		  a_date = Date.today
		  a_date -= some_days
		  item.last_calibrated_on = a_date
		  item.save
	  end
    redirect_to( items_url )
  
  end

  def search_remote
    @item = Item.first
    if params[:description] or params[:sn]
      search_term = params[:description]
      if search_term.length < 1
        search_term = params[:sn]
        search_term = '%' + search_term + '%'
        @search_results = Item.all( :conditions => ["org_sn LIKE ?", search_term])
      else
        search_term = '%' + search_term + '%'
        @search_results = Item.all( :conditions => ["description LIKE ?", search_term])
      end
    end
    respond_to do |format|
      format.html # search_remote.html.erb
      format.xml  { render :xml => @search_results }
    end

  end

  def issue_remote
    @issues = Issue.all( :order => 'created_at DESC' )
    render 'issues', :locals => { :issues => @issues }
  end

  def dependent_remote
    @dependents = Dependent.all( :order => 'item_id')
    render 'dependents', :locals => {:dependents => @dependents}
  end

  def show_thirty_days
    @display_group = Item.due_in( 30 )
    @test_thirty_days = @display_group.size
  end

  def show_all_items
    @display_group = Item.all( :order => :description )
  end

  def show_sixty_days
    @display_group = Item.due_in( 60 )
  end

  def show_inactive
    @items = Item.inactive.paginate :page => params[:page], :per_page => params[:per_page]
  end

  def show_in_cal
    @items = Item.in_cal.paginate :page => params[:page], :per_page => params[:per_page]
  end

  def printable_due_cal
    @due_cal = Item.due_cal
    respond_to do |format|
      format.html { render 'printable_due_cal', :layout => false }   # printable_due_cal.html.erb
      format.xml  { render :xml => @due_cal }
    end
  end

  def printable_in_cal
    @in_cal = Item.in_cal
    respond_to do |format|
      format.html { render 'printable_in_cal', :layout => false }   # printable_in_cal.html.erb
      format.xml  { render :xml => @in_cal }
    end
  end

  def printable_thirty_days
    @thirty_days = Item.due_in( 30 )
    respond_to do |format|
      format.html { render 'printable_thirty_days', :layout => false }   # printable_thirty_days.html.erb
      format.xml  { render :xml => @thirty_days }
    end
  end

  def show_all_events
    @events = Event.all( :order => 'cal_date DESC').paginate :page => params[:page], :per_page => params[:per_page], :per_page => 20

    respond_to do |format|
      format.html { render 'show_all_events' }
      format.xml {render :xml => @events }
    end
  end
  
  def show_all_documents
    @documents = ExternalDoc.all( :order => 'item_id, updated_at')
    
    respond_to do |format|
      format.html #show_all_documents.hrml.erb
      format.xml {render :xml => @documents }
    end
  end
  
  def show_all_items_by_location
    @display_group = Item.all( :order => :location )
  end
end