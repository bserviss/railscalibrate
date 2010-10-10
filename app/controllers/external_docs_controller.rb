class ExternalDocsController < ApplicationController
  # GET /external_docs
  # GET /external_docs.xml
   before_filter :get_item, :except => [ :update, :create ]

  def get_item
    @item = Item.find(params[:item_id])
  end

  def index
    @external_docs = @item.external_docs.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @external_docs }
    end
  end

  # GET /external_docs/1
  # GET /external_docs/1.xml
  def show
    @external_doc = @item.external_docs.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @external_doc }
    end
  end

  # GET /external_docs/new
  # GET /external_docs/new.xml
  def new
    #@event = @item.events.new
    @external_doc = @item.external_docs.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @external_doc }
    end
  end

  # GET /external_docs/1/edit
  def edit
    @external_doc = @item.external_docs.find(params[:id])
  end

  # POST /external_docs
  # POST /external_docs.xml
  def create
    @item = Item.find( params[:external_doc][:item_id] )
    @external_doc = @item.external_docs.new(params[:external_doc])

    respond_to do |format|
      if @external_doc.save
        flash[:notice] = 'Document was successfully created'
        format.html { redirect_to(item_external_docs_path(@item.id)) }
        format.xml  { render :xml => @external_doc, :status => :created, :location => @external_doc }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @external_doc.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /external_docs/1
  # PUT /external_docs/1.xml
  def update
    @item = Item.find( params[:external_doc][:item_id] )
    @external_doc = @item.external_docs.find(params[:id])

    respond_to do |format|
      if @external_doc.update_attributes(params[:external_doc])
        format.html { redirect_to(item_external_docs_path(@item.id), :notice => 'External doc was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @external_doc.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /external_docs/1
  # DELETE /external_docs/1.xml
  def destroy
    @external_doc = @item.external_docs.find(params[:id])
    @external_doc.destroy

    respond_to do |format|
      format.html { redirect_to(item_external_docs_url) }
      format.xml  { head :ok }
    end
  end
end
