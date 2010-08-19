class UsersController < ApplicationController
#  filter_resource_access
#  layout 'welcome'
  layout 'application'
  before_filter :mailer_set_url_options
     
  def index
    @users = User.all :order => :username
  end

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def edit
    @user = current_user
  end

  def create
    @user = User.new(params[:user])
    Role.all.each do |r|
      @user.role_id = r.id if r.name == "guest"
    end
    if @user.save
        flash[:notice] = 'Registration successful.'
        redirect_to orient_path
      else
        render :action => 'new'
    end
  end

  def update
    @user = current_user
    if @user.update_attributes(params[:user])
      flash[:notice] = 'Successfully modified profile.'
      redirect_to root_url
    else
        render :action => 'edit'
    end
  end
  
  def destroy
    User.destroy params[:id]
    respond_to do |format|
      format.html { redirect_to(users_url) }
      format.xml  { head :ok }
    end
  end
  
  def invite
    @user = current_user
    @friend = User.new
  end

  # Design Notes
  # It can happen that a user has no friends established (registered on own initiative, for example).
  # For some reason the @invited_friend hash may be nil (actually {nil, nil}).  Skip the update in this case.
  def invitation

    # Person being invited, may be a member already, or not; based on email uniqueness
    if User.exists?(:email => "#{params[:user][:email]}")
      invite_member params
    else
      invite_non_member params
    end
    logger.info "*-*-*-* #{flash[:notice]}"  unless flash[:notice].nil?
    logger.info "*-*-*-* #{flash[:warning]}" unless flash[:warning].nil?
    
    # do not redirect as flash will be lost; provide @user for use in _sidebar.
    @user = current_user
    render :action => :invite
  end
# = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =
private

  def mailer_set_url_options
# TEMPORARY -- turned off Thurs pm 7-22 to enable app to run, email may not work
#    MemberMailer::Base.default_url_options[:host] = request.host_with_port
  end
end
