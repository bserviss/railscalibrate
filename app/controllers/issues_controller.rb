class IssuesController < ApplicationController
   before_filter :get_item_id, :except => [ :update, :create]
   before_filter :get_item_id_params, :only => [:update, :create ]

  def get_item_id
    @item = Item.find(params[:item_id])
  end

  def get_item_id_params
    @item = Item.find( params[:issue][:item_id] )
  end

  def index
    @issues = @item.issues.all( :order => "created_at DESC" )
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @events }
    end
  end

  def show
    @issue = @item.issues.find( params[:id] )
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @event }
    end
  end

  def new
    @issue = @item.issues.new
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @event }
    end
  end

  def edit
    @issue = @item.issues.find( params[:id] )
  end

  def create
    @issue = @item.issues.create( params[:issue] )
    respond_to do |format|
      if @issue.save
        flash[:notice] = 'Issue was successfully created.'
        format.html { redirect_to(item_issues_path(@item.id) ) }
        format.xml  { render :xml => @issue, :status => :created, :location => @issue }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @issue.errors, :status => :unprocessable_entity }
      end
    end
  end

  def update
    @issue = @item.issues.find(params[:id])

    respond_to do |format|
      if @issue.update_attributes(params[:issue])
        flash[:notice] = 'Issue was successfully updated.'
        format.html { redirect_to(item_issues_path(@item.id) ) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @issue.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
	@issue = @item.issues.find( params[:id] )
  @issue.destroy

  respond_to do |format|
    format.html { redirect_to(item_issues_path(@item.id)) }
    format.xml  { head :ok }
  end
  end


end
