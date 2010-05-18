class UserSessionsController < ApplicationController
 Authlogic::Session::Base.controller = Authlogic::ControllerAdapters::RailsAdapter.new(self) 
 layout 'users'

  # creates user's logon session    
  def new
    logger.error("*-*-* UserSessionsController.new")
    @user_session = UserSession.new
    logger.error("*-*-* UserSessions Controller.new")
  end
  
  def create
    @user_session = UserSession.new(params[:user_session])
    if @user_session.save
      flash[:notice] = "Successfully logged in."
      redirect_to gifts_path
    else
      render :action => 'new'
    end
  end
  
  def destroy
    @user_session = UserSession.find
    @user_session.destroy
    flash[:notice] = "Successfully logged out."
    redirect_to root_url
  end
end
