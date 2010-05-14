# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  include Authentication
  include AuthenticatedSystem 

  helper :all
  protect_from_forgery
  before_filter { |c| Authorization.current_user = c.current_user }

  helper_method :current_user
  helper_method :show_links?
  filter_parameter_logging :password
  
  # = = = = = =  = = = = = = = = = == =  
#  protected
  
  def permission_denied
    flash[:error] = "Sorry, you are NOT allowed to access that page."
    redirect_to root_url
  end

  # = = = = = =  = = = = = = = = = == =  
  
#   private

   def show_links?
     false
   end
   
   def current_user_session
     return @current_user_session if defined?(@current_user_session)
     @current_user_session = UserSession.find
   end

   def current_user
     return @current_user if defined?(@current_user)
     @current_user = current_user_session && current_user_session.record
   end

end
