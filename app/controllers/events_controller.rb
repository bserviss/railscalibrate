class EventsController < ApplicationController
  # GET /events
  # GET /events.xml
  
   before_filter :get_event, :except => [ :update, :create]

  def get_event
    @item = Item.find(params[:item_id])
  end  
  
  def index
    @events = @item.events.find( :all, :order => "cal_date DESC" )
    #@events = Event.find( :all, :conditions => ["items_id = ?", params[:item_id] ] )
	#@item_id = params[:item_id]
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @events }
    end
  end

  # GET /events/1
  # GET /events/1.xml
  def show
	@event = @item.events.find( params[:id] )
	#@event = Event.find( :first, :conditions => ["items_id = ?", params[:id] ] )
    #@event = Event.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @event }
    end
  end

  # GET /events/new
  # GET /events/new.xml
  def new
    @event = @item.events.new
    @calibrators = Calibrator.find( :all )
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @event }
    end
  end

  # GET /events/1/edit
  def edit
    @event = @item.events.find( params[:id] )
    @calibrators = Calibrator.find( :all )
    #@event = Event.find( :first, :conditions => ["items_id = ?", params[:id] ] )
  end

  def return_from_cal
    if @item.inCal
      #if item inCal then redirect to edit of most current cal event
      event = @item.events.find( :first, :order => "cal_date DESC" )
      redirect_to( edit_item_event_path( @item.id, event.id ))
    end
  
  end

  # POST /events
  # POST /events.xml
  def create
    @calibrators = Calibrator.find( :all )
    @item = Item.find( params[:event][:item_id] )
    @event = @item.events.create( params[:event] )
    #set inCal to true, change to an option on the form?
    @item.inCal = true
    @item.save
    respond_to do |format|
      if @event.save
        flash[:notice] = 'Event was successfully created. Status changed to inCal'
        format.html { redirect_to(item_events_path(@item.id) ) }
        format.xml  { render :xml => @event, :status => :created, :location => @event }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @event.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /events/1
  # PUT /events/1.xml
  def update
    @calibrators = Calibrator.find( :all )
    @item = Item.find( params[:event][:item_id] )
    @event = @item.events.find(params[:id])
    
    respond_to do |format|
      if @event.update_attributes(params[:event])

        if @item.inCal
          @item.last_calibrated_on = @event.cal_date
          @item.inCal = false
          @item.save
        end
        flash[:notice] = 'Event was successfully updated.'
        format.html { redirect_to(item_events_path(@item.id) ) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @event.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /events/1
  # DELETE /events/1.xml
  def destroy
	@event = @item.events.find( params[:id] )
    #@event = Event.find(params[:id])
    @event.destroy

    respond_to do |format|
      format.html { redirect_to(item_events_path(@item.id)) }
      format.xml  { head :ok }
    end
  end
end
