class ItemsController < ApplicationController
  before_filter :get_item

  def get_item
    @item = Item.first
  end
  # GET /items
  # GET /items.xml
  def index
    @item = Item.first
    @in_cal = Item.in_cal
    @due_cal = Item.due_cal
    @test_due_cal = Item.due_cal.paginate :page => params[:page], :per_page => params[:per_page]

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
  def test_loader
  	for i in ( 1..500)
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
    @display_group = Item.thirty_days
  end

  def show_all_items
    @display_group = Item.all( :order => :description )
  end

  def show_sixty_days
    @display_group = Item.sixty_days
  end

  def show_inactive
    @display_group = Item.inactive
  end

  def remote
    @display_group = case params[:token]
      when 'IA' then Item.inactive
      when '30' then Item.thirty_days
      when 'sixty_r' then Item.sixty_days
      when 'over_r' then Item.ninety_days
      when 'all_r' then Item.all( :order => :description )
    else
      []
    end
    render "group", :locals => { :aGroup => @display_group, :show_hide => 1, :aToken => params[:token] }
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
    @thirty_days = Item.thirty_days
    respond_to do |format|
      format.html { render 'printable_thirty_days', :layout => false }   # printable_thirty_days.html.erb
      format.xml  { render :xml => @thirty_days }
    end
  end
end