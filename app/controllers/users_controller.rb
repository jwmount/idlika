class UsersController < ApplicationController
#  filter_resource_access
  layout = 'welcome'
     
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
    @user = User.new(params[:user])
    flash[:notice] = ''
    flash[:waring] = ''
#    if @user.save
        MemberMailer.deliver_invitation(params[:user])
        logger.info "*-*-*-* Invitation emailed to #{@user.username} with email #{@user.email}."
        flash[:notice] = "Your invitation to #{@user.username} has been sent."
#    else
#       logger.info "*-*-*-* Invitation to #{@user.username} using #{@user.email} could not be saved."
#       flash[:warning] = "Your invitation to #{@user.username} with email #{@user.email} could not be created.  " +
#                         "  This can happen if #{@user.username} already is a member."
#    end
    redirect_to :action => 'invite' 
  end
  
end
