class GiversController < ApplicationController
  # GET /givers
  # GET /givers.xml
  def index
    @givers = Giver.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @givers }
    end
  end

  # GET /givers/1
  # GET /givers/1.xml
  def show
    @giver = Giver.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @giver }
    end
  end

  # GET /givers/new
  # GET /givers/new.xml
  def new
    @giver = Giver.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @giver }
    end
  end

  # GET /givers/1/edit
  def edit
    @giver = Giver.find(params[:id])
  end

  # POST /givers
  # POST /givers.xml
  def create
    @giver = Giver.new(params[:giver])

    respond_to do |format|
      if @giver.save
        flash[:notice] = 'Giver was successfully created.'
        format.html { redirect_to(@giver) }
        format.xml  { render :xml => @giver, :status => :created, :location => @giver }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @giver.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /givers/1
  # PUT /givers/1.xml
  def update
    @giver = Giver.find(params[:id])

    respond_to do |format|
      if @giver.update_attributes(params[:giver])
        flash[:notice] = 'Giver was successfully updated.'
        format.html { redirect_to(@giver) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @giver.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /givers/1
  # DELETE /givers/1.xml
  def destroy
    @giver = Giver.find(params[:id])
    @giver.destroy

    respond_to do |format|
      format.html { redirect_to(givers_url) }
      format.xml  { head :ok }
    end
  end
end
