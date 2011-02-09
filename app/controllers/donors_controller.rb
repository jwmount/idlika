class DonorsController < ApplicationController

  before_filter :require_user 
  before_filter :find_user 
  layout 'application'

  # GET /donors
  # GET /donors.xml
  def index
    @donors = Donor.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @donors }
    end
  end

  # GET /donors/1
  # GET /donors/1.xml
  def show
    @donor = Donor.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @donor }
    end
  end

  # GET /donors/new
  # GET /donors/new.xml
  def new
    @donor = Donor.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @donor }
    end
  end

  # GET /donors/1/edit
  def edit
    @donor = Donor.find(params[:id])
  end

  # POST /donors
  # POST /donors.xml
  def create
    @donor = Donor.new(params[:donor])

    respond_to do |format|
      if @donor.save
        flash[:notice] = 'Donor was successfully created.'
        format.html { redirect_to(@donor) }
        format.xml  { render :xml => @donor, :status => :created, :location => @donor }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @donor.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /donors/1
  # PUT /donors/1.xml
  def update
    @donor = Donor.find(params[:id])

    respond_to do |format|
      if @donor.update_attributes(params[:donor])
        flash[:notice] = 'Donor was successfully updated.'
        format.html { redirect_to(@donor) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @donor.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /donors/1
  # DELETE /donors/1.xml
  def destroy
    @donor = Donor.find(params[:id])
    @donor.destroy

    respond_to do |format|
      format.html { redirect_to(donors_url) }
      format.xml  { head :ok }
    end
  end
  # = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =

  private

    # who's logged on.  If friend is 'self' set :friend_id to nil (no friend is active).
    def find_user
      @user = @current_user
      @user = User.find @user.friend_id unless @user.friend_id.nil?
      @user.friend_id = nil if (@user.friend_id == @current_user[:id])
      @user.save
    end

end
