class CalibratorsController < ApplicationController
  # GET /calibrators
  # GET /calibrators.xml
  def index
    @calibrators = Calibrator.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @calibrators }
    end
  end

  # GET /calibrators/1
  # GET /calibrators/1.xml
  def show
    @calibrator = Calibrator.find(params[:id])

    @events_over_year = Event.find(:all, :conditions => ["calibrator_id = ? and cal_date > ?", @calibrator.id, 1.year.ago],
          :order => "cal_date DESC"  )

    @in_cal = []
    @events = []
    @events_over_year.each do | e |
      the_item = Item.find( e.item_id )
      if the_item.inCal == true
        @in_cal << e
      else
        @events << e
      end

    end

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @calibrator }
    end
  end

  # GET /calibrators/new
  # GET /calibrators/new.xml
  def new
    @calibrator = Calibrator.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @calibrator }
    end
  end

  # GET /calibrators/1/edit
  def edit
    @calibrator = Calibrator.find(params[:id])
  end

  # POST /calibrators
  # POST /calibrators.xml
  def create
    @calibrator = Calibrator.new(params[:calibrator])

    respond_to do |format|
      if @calibrator.save
        flash[:notice] = 'Calibrator was successfully created.'
        format.html { redirect_to(@calibrator) }
        format.xml  { render :xml => @calibrator, :status => :created, :location => @calibrator }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @calibrator.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /calibrators/1
  # PUT /calibrators/1.xml
  def update
    @calibrator = Calibrator.find(params[:id])

    respond_to do |format|
      if @calibrator.update_attributes(params[:calibrator])
        flash[:notice] = 'Calibrator was successfully updated.'
        format.html { redirect_to(@calibrator) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @calibrator.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /calibrators/1
  # DELETE /calibrators/1.xml
  def destroy
    @calibrator = Calibrator.find(params[:id])
    @calibrator.destroy

    respond_to do |format|
      format.html { redirect_to(calibrators_url) }
      format.xml  { head :ok }
    end
  end
end
