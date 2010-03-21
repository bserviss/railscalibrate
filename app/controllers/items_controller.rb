class ItemsController < ApplicationController
  # GET /items
  # GET /items.xml
  def index
    @in_cal = Item.find( :all, :conditions => ["inCal = ? and inactive = ?", true, 0],
        :order => :last_calibrated_on ) || []
    @due_cal = []
    @due_cal = Item.due_cal

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @items }
    end
  end

  # GET /items/1
  # GET /items/1.xml
  def show
    @item = Item.find(params[:id])
    @issues = @item.issues.find( :all, :order => 'created_at DESC')
    @dependents = @item.dependents.find( :all, :order => 'created_at DESC')
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
    @item = Item.new(params[:item])

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
  
  def test_loader
  	for i in ( 1..500)
	  	item = Item.new
		  item.description = 'test-' + i.to_s
		  item.mfgr = 'test'
      item.pn = '1234'
      item.org_sn = '123'
      item.cal_cycle_days = '365'
		  some_days = rand(500)
		  aDate = Date.today
		  aDate -= some_days
		  item.last_calibrated_on = aDate
		  item.save
	  end
    redirect_to( items_url )
  
  end

  def remote
    if params[:token] == 'IA'
      @in_active = Item.find( :all, :conditions => ["inactive = ?", 1],
        :order => :last_calibrated_on ) || []
      render :partial => "group", :locals => { :aGroup => @in_active, :show_hide => 1, :aToken => 'IA' }
    end
    
    if params[:token] == '30'
      @thirty = Item.thirty_days
      render :partial => "group", :locals => { :aGroup => @thirty, :show_hide => 1, :aToken => '30' }
    end

    if params[:token] == 'sixty_r'
      @sixty = Item.find_by_sql( 'select * from "items" where ' +
          "(julianday('now') - julianday(items.last_calibrated_on)) > ( items.cal_cycle_days + 31) " +
          "and " +
          "(julianday('now') - julianday(last_calibrated_on)) < ( cal_cycle_days + 61 ) " +
          "order by last_calibrated_on"
        )
      render :partial => "group", :locals => { :aGroup => @sixty, :show_hide => 1, :aToken => 'sixty_r' }
    end

    if params[:token] == 'over_r'
      @over = Item.find_by_sql( 'select * from "items" where ' +
          "(julianday('now') - julianday(items.last_calibrated_on)) < ( items.cal_cycle_days + 61) "  +
          "order by last_calibrated_on"
        )

      render :partial => "group", :locals => { :aGroup => @over, :show_hide => 1, :aToken => 'over_r' }
    end

    if params[:token] == 'all_r'
      @all_items = Item.find( :all, :order => :description )
      render :partial => "group", :locals => { :aGroup => @all_items, :show_hide => 1, :aToken => 'all_r' }
    end

    if params[:token] == 'issues_r'
      @issues = Issue.find( :all, :order => 'created_at DESC')
      render :partial => "issues", :locals => {:issues => @issues }
    end

    if params[:token] == 'dependents_r'
      @dependents = Dependent.find( :all, :order => 'item_id')
      render :partial => 'dependents', :locals => {:dependents => @dependents}
    end

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
end