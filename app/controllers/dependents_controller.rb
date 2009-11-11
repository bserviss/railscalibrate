class DependentsController < ApplicationController
  # GET /dependents
  # GET /dependents.xml
  def index
    @dependents = Dependent.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @dependents }
    end
  end

  # GET /dependents/1
  # GET /dependents/1.xml
  def show
    @dependent = Dependent.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @dependent }
    end
  end

  # GET /dependents/new
  # GET /dependents/new.xml
  def new
    @dependent = Dependent.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @dependent }
    end
  end

  # GET /dependents/1/edit
  def edit
    @dependent = Dependent.find(params[:id])
  end

  # POST /dependents
  # POST /dependents.xml
  def create
    @dependent = Dependent.new(params[:dependent])

    respond_to do |format|
      if @dependent.save
        flash[:notice] = 'Dependent was successfully created.'
        format.html { redirect_to(@dependent) }
        format.xml  { render :xml => @dependent, :status => :created, :location => @dependent }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @dependent.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /dependents/1
  # PUT /dependents/1.xml
  def update
    @dependent = Dependent.find(params[:id])

    respond_to do |format|
      if @dependent.update_attributes(params[:dependent])
        flash[:notice] = 'Dependent was successfully updated.'
        format.html { redirect_to(@dependent) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @dependent.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /dependents/1
  # DELETE /dependents/1.xml
  def destroy
    @dependent = Dependent.find(params[:id])
    @dependent.destroy

    respond_to do |format|
      format.html { redirect_to(dependents_url) }
      format.xml  { head :ok }
    end
  end
end
