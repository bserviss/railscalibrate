class ItemsController < ApplicationController
  # GET /items
  # GET /items.xml
  def index
    #may need a complete item list that we can search on
    @items = Item.find( :all, :order => :last_calibrated_on,
          :conditions => [ "inCal = ? and inactive = ?", false, 0 ] )

    @in_cal = Item.find( :all, :conditions => ["inCal = ? and inactive = ?", true, 0],
        :order => :last_calibrated_on ) || []

    @in_active = Item.find( :all, :conditions => ["inactive = ?", 1],
        :order => :last_calibrated_on ) || []

    @due_cal = []
    @thirty = []
    @sixty = []
    @over = []
    #have to iterate over the items because cal cycle days is per item
    @items.each do |i|
      i.cal_cycle_days = 365 if i.cal_cycle_days.nil?
      diff = ( (Date.today - i.last_calibrated_on.to_date).to_i - i.cal_cycle_days )
      if diff >= 0 then
        @due_cal << i
      end
      case diff
      when ( -30 .. -1 )
        @thirty << i
      when ( -60 .. -31 )
        @sixty << i
      else
        @over << i
      end
    end


    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @items }
    end
  end

  # GET /items/1
  # GET /items/1.xml
  def show
    @item = Item.find(params[:id])

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
#test code to load some data into the model
#	for i in ( 1..500)
#		item = Item.new
#		item.description = 'test-' + i.to_s
#		item.mfgr = 'test'
#		some_days = rand(500)
#		aDate = Date.today
#		aDate -= some_days
#		item.last_calibrated_on = aDate
#		item.save
#	end

    respond_to do |format|
      format.html { redirect_to(items_url) }
      format.xml  { head :ok }
    end
  end
  
  def test_loader
    #utility method to fix some errors in the database
    #to be removed
    @item = Item.find( :all )
    for i in @item
      i.inactive = 0
      i.inCal = false
      i.save
    end
    flash[:notice]= 'items inactive and incal set to defaults'
#    for i in ( 1..10 )
#      item = Item.new
#      item.description = 'test-' + i.to_s
#      item.mfgr = 'test'
#      some_days = rand(180)
#      if rand(10) > 5
#        some_days = some_days * -1
#      end
#      aDate = Date.today
#      aDate += some_days
#      item.last_calibrated_on = aDate
#      item.save
#    end
#    flash[:notice] = 'Test data added.'
    redirect_to( items_url )
  
  end

end