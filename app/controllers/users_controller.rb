class UsersController < ApplicationController
#  filter_resource_access
  before_filter :mailer_set_url_options
     
  def index
    @users = User.all
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
        redirect_to root_url
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
  
  def invite
    @user = User.new
    @body = "Hey, this is cool.\n\n" +
            "I've arranged to get you access to the Beta version.  \n\n" +
            "and Login with the User name and Access Code below (you can change these afterwards).  \n\n" +
            "Click on http://www.idlika.com"
  end

  def invitation
    flash[:notice] = ''
    flash[:waring] = ''
    @friend = User.new(params[:user])
    @user = User.find current_user[:id]
    @invited_friend = { @friend.email, @friend.username }
    @user.friends = @user.friends.empty? ? @invited_friend : @user.friends.update(@invited_friend)
  
    if @user.save
        MemberMailer.deliver_invitation(params[:user], @user.email)
        logger.info "*-*-*-* Invitation emailed to #{@friend.username} with email #{@friend.email}."
        flash[:notice] = "Your invitation to #{@friend.username} has been sent to #{@friend.email}."
    else
       logger.info "*-*-*-* Invitation to #{@friend.username} using #{@friend.email} could not be saved."
       flash[:warning] = "Your invitation to #{@friend.username} with email #{@friend.email} could not be created.  " +
                         "  This can happen if #{@friend.username} already is a member."
    end
    redirect_to :action => 'invite' 
  end
# = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =
private

  def mailer_set_url_options
    ActionMailer::Base.default_url_options[:host] = request.host_with_port
  end
end
