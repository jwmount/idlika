class UserSessionsController < ApplicationController
 Authlogic::Session::Base.controller = Authlogic::ControllerAdapters::RailsAdapter.new(self) 
 layout 'welcome'

  # creates user's logon session    
  def new
    @user_session = UserSession.new
  end
  
  def create
    @user_session = UserSession.new(params[:user_session])
    logger.info "@user_session #{@user_session} created."
    
    if @user_session.save
      redirect_to gifts_path   #this would appear to go directly, but it goes to logon again?  
    else
      render :action => 'new'
    end
  end
  
  def destroy
    @user_session = UserSession.find
    logger.info "@user_session #{@user_session} terminated."
    @user_session.destroy
 #   flash[:notice] = "Successfully logged out."
    redirect_to root_url
  end
  
  def orient
  end
  
  
end
