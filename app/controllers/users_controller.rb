class UsersController < ApplicationController
#  filter_resource_access
  layout 'welcome'
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
#    @user = current_user
    @friend = User.new
  end

  # Design Notes
  # It can happen that a user has no friends established (registered on own initiative, for example).
  # For some reason the @invited_friend hash may be nil (actually {nil, nil}).  Skip the update in this case.
  def invitation
    flash[:notice] = ''
    flash[:waring] = ''

    # Person doing the invitation
    @user = current_user
    
    # Person being invited
    @friend = User.new(params[:user])
    @friend.password = 'guest'
    @friend.password_confirmation = 'guest'
    logger.info "*-*-*-*-* #{@user.username} invited #{@friend.username} @ #{@friend.email} to join Idlika"

    #Add email and name to host's list of friends (or create it if this is first one!)
    begin
      @user.friends[@friend.email] = @friend.username
    rescue
      @user.friends = {@friend.email, @friend.username}
    
    end
    
    #We COULD Seed friend's list?  MAYBE A PRIVACY PROBLEM
#    @friend.friends = @user.friends
            
    if @user.save and @friend.save!
      MemberMailer.deliver_invitation(params[:user], @user.email)
      logger.info "*-*-*-* Invitation emailed to #{@friend.username} with email #{@friend.email}."
      flash[:notice] = "Your invitation to #{@friend.username} has been sent to #{@friend.email}.\nYou can invite someone else now."
    else
      logger.info "*-*-*-* Invitation to #{@friend.username} using #{@friend.email} FAILED."
      flash[:warning] = "Your invitation to #{@friend.username} with email #{@friend.email} could not be created.  " +
                       "Usually this means #{@friend.username} is already a member and #{@friend.email} is already taken."
    end
    
    redirect_to :action => 'invite' 
  end
# = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =
private

  def mailer_set_url_options
# TEMPORARY -- turned off Thurs pm 7-22 to enable app to run, email may not work
#    MemberMailer::Base.default_url_options[:host] = request.host_with_port
  end
end
