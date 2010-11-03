# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  include Authentication
  include AuthenticatedSystem 

  helper :all
  protect_from_forgery
# protect_from_forgery :secret => '9847618af6620f8564a5f7ef12f48a5a'
  before_filter { |c| Authorization.current_user = c.current_user }

  helper_method :current_user
  helper_method :show_links?
  filter_parameter_logging :password

  
  def FB_init
    update_page do |page|
      page.insert_html :bottom, 'list', "<li>#{@item.name}</li>"
      page.visual_effect :highlight, 'list'
      page.hide 'status-indicator', 'cancel-link'
    end
  end
  

  # = = = = = =  = = = = = = = = = == =  
#  protected
  
  def permission_denied
    flash[:error] = "Sorry, you are not allowed to access that page."
    redirect_to root_url
  end

  # = = = = = = = = = = = = = = = == =  

#   private

   def show_links?
     ['yes', 'Yes', 'YES'].include? ENV['SHOW_LINKS']
   end
   
   def current_user_session
     return @current_user_session if defined?(@current_user_session)
     @current_user_session = UserSession.find
   end

   # current_user can only be altered by login/logout
   def current_user
     return @current_user if defined?(@current_user)
     @current_user = current_user_session && current_user_session.record
   end


   def invite_member params
     @host = current_user
     @friend = User.find_by_email params[:user][:email]

     #Add @friend's email and name to host's list of friends (or create it if this is first one!)
     begin
       @host.friends[@friend.email] = @friend.username
     rescue
       @host.friends = {@friend.email, @friend.username}
     end

     # Put @host's credentials in @friend's list
     begin
       @friend.friends[@friend.email] = @friend.username
     rescue
       @friend.friends = {@friend.email, @friend.username}
     end

     if @host.save and @friend.save
       MemberMailer.deliver_invitation(params[:user], @host.email)
       flash[:notice] = "You've invited Idlika member #{@friend.username}.  You can invite someone else now."
     else
       flash[:notice] = "Your invitation to Idlika member #{@friend.username} using #{@friend.email} could not be created.  " 
     end
   end
   
   def invite_non_member params
     @host = current_user
     @friend = User.new
     
     @friend.username = params[:user][:username]
     @friend.password = ENV['INVITATION_PASSWORD']
     @friend.password_confirmation = ENV['INVITATION_PASSWORD']
     @friend.email = params[:user][:email]
     @friend.terms_accepted_cb = false

     #Add email and name to host's list of friends (or create it if this is first one!)
     begin
       @host.friends[@friend.email] = @friend.username
     rescue
       @host.friends = {@friend.email, @friend.username}
     end
     
     begin
       @friend.friends[@host.email] = @host.username
     rescue
       @friend.friends = {@host.email, @host.username}
     end
          
     if @host.save and @friend.save!
       #New invitation accounts need corresponding registries
       @registry = Registry.new(:name=>"#{ENV['DEFAULT_REGISTRY_NAME']}", :description=>"Items added recently.", :user_id=>@friend.id)
       @registry.save!
       MemberMailer.deliver_invitation(params[:user], @host.email)
       flash[:notice] = "You've invited #{@friend.username} at #{@friend.email} to visit you on Idlika.  You can invite someone else now."
     else
       flash[:warning] = "Your invitation to #{@friend.username} with email #{@friend.email} could not be created.  " +
                        "Usually this means #{@friend.username} is already a member and #{@friend.email} is already taken."
     end
 end
   
   
end

