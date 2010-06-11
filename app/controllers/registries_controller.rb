class RegistriesController < ApplicationController
  
  before_filter :find_user

  # returns a collection of registries for a user or friend    
  def index
    if @user.current_friend_id.nil?
      @registries = @user.registries.find( :all )
    else
      @registries = (User.find @user.current_friend_id ).registries.find(:all)
    end

    respond_to do |format|
      format.html { redirect_to user_gifts_path(@user) }
    end
  end

  # details about a registry
  def show
    @action = @user.current_friend_id.nil? ? 'index' : 'select_friend'
    respond_to do |format|
      # work out named path at some point
      format.html { redirect_to :controller => 'gifts', :action => "#{@action}",  :registry_id => params[:id] }
      format.xml  { render :xml => @registry }
    end
  end

  # GET /registries/new
  # GET /registries/new.xml
  def new
    @registry = @user.registries.new

    respond_to do |format|
      format.html  # new.html.erb
      format.xml  { render :xml => @registry }
    end
  end

  # GET /registries/1/edit
  def edit
    @registry = @user.registries.find(params[:id])
  end

  # POST /registries
  # POST /registries.xml
  def create
    @registry = @user.registries.new(params[:registry])

    respond_to do |format|
      if @registry.save
        flash[:notice] = 'Registry was successfully created.'
        format.html { redirect_to gifts_path }
        format.xml  { render :xml => @registry, :status => :created, :location => [ @user, @registry] }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @registry.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /registries/1
  # PUT /registries/1.xml
  def update
    @registry = @user.registries.find(params[:id])

    respond_to do |format|
      if @registry.update_attributes(params[:registry])
        flash[:notice] = 'Registry was successfully updated.'
        format.html { redirect_to([@user,@registry]) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @registry.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /registries/1
  # DELETE /registries/1.xml
  def destroy
    @registry = @user.registries.find(params[:id])
    @registry.destroy

    respond_to do |format|
      format.html { redirect_to( user_registries_url(@user)) }
      format.xml  { head :ok }
    end
  end

  
# + + + + + + + + + + + + + + + + + + + + + + + + + + + + +
private

  def find_user
    @user = current_user
    logger.info "*-*-*-*-* registries_controller.find_user: @user => #{@user.username}, params[:id]=>#{params[:id]}."
  end
  
end
