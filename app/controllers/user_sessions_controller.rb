class UserSessionsController < ApplicationController
 Authlogic::Session::Base.controller = Authlogic::ControllerAdapters::RailsAdapter.new(self) 
 layout 'welcome'

  def new
    @user_session = UserSession.new
  end

  # creates user's logon session    
  def create
    @user_session = UserSession.new(params[:user_session])
    session.clear
    logger.info "@user_session #{@user_session} created."
    if @user_session.save
      redirect_to gifts_path   
    else
      render :action => 'new'
    end
  end
  
  def destroy
    @user_session = UserSession.find
    logger.info "@user_session #{@user_session} terminated."
    @user_session.destroy
    redirect_to root_url
  end
  
  def orient
  end
  
  
end
