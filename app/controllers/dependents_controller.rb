class DependentsController < ApplicationController
   before_filter :get_item_id, :except => [ :update, :create]
   before_filter :get_item_id_params, :only => [:update, :create ]

  def get_item_id
    @item = Item.find(params[:item_id])
  end

  def get_item_id_params
    @item = Item.find( params[:dependent][:item_id] )
  end
  # GET /dependents
  # GET /dependents.xml
  def index
    @dependents = @item.dependents.find( :all, :order => "created_at DESC" )

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @dependents }
    end
  end

  # GET /dependents/1
  # GET /dependents/1.xml
  def show
    @dependent = @item.dependents.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @dependent }
    end
  end

  # GET /dependents/new
  # GET /dependents/new.xml
  def new
    @dependent = @item.dependents.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @dependent }
    end
  end

  # GET /dependents/1/edit
  def edit
    @dependent = @item.dependents.find(params[:id])
  end

  # POST /dependents
  # POST /dependents.xml
  def create
    @dependent = @item.dependents.new(params[:dependent])

    respond_to do |format|
      if @dependent.save
        flash[:notice] = 'Dependent was successfully created.'
        format.html { redirect_to item_dependents_path(@item.id) }
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
    @dependent = @item.dependents.find(params[:id])

    respond_to do |format|
      if @dependent.update_attributes(params[:dependent])
        flash[:notice] = 'Dependent was successfully updated.'
        format.html { redirect_to item_dependents_path(@item.id) }
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
    @dependent = @item.dependents.find(params[:id])
    @dependent.destroy

    respond_to do |format|
      format.html { redirect_to(item_dependents_path( @item.id )) }
      format.xml  { head :ok }
    end
  end
end
