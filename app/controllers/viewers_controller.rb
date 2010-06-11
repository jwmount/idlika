class ViewersController < ApplicationController
  # GET /viewers
  # GET /viewers.xml
  def index
    @viewers = Viewer.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @viewers }
    end
  end

  # GET /viewers/1
  # GET /viewers/1.xml
  def show
    @viewer = Viewer.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @viewer }
    end
  end

  # GET /viewers/new
  # GET /viewers/new.xml
  def new
    @viewer = Viewer.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @viewer }
    end
  end

  # GET /viewers/1/edit
  def edit
    @viewer = Viewer.find(params[:id])
  end

  # POST /viewers
  # POST /viewers.xml
  def create
    @viewer = Viewer.new(params[:viewer])

    respond_to do |format|
      if @viewer.save
        flash[:notice] = 'Viewer was successfully created.'
        format.html { redirect_to(@viewer) }
        format.xml  { render :xml => @viewer, :status => :created, :location => @viewer }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @viewer.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /viewers/1
  # PUT /viewers/1.xml
  def update
    @viewer = Viewer.find(params[:id])

    respond_to do |format|
      if @viewer.update_attributes(params[:viewer])
        flash[:notice] = 'Viewer was successfully updated.'
        format.html { redirect_to(@viewer) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @viewer.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /viewers/1
  # DELETE /viewers/1.xml
  def destroy
    @viewer = Viewer.find(params[:id])
    @viewer.destroy

    respond_to do |format|
      format.html { redirect_to(viewers_url) }
      format.xml  { head :ok }
    end
  end
end
