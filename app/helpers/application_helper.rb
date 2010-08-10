# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper

  # use friends hash as basis for looking at friends' registries.
  def friend_registry_links
    if @user.friends.empty?
      return {"info@idlika.com", "no friends yet"}
    end
    select :key, :value, @user.friends.each {|k,v| [k,v] }   unless @user.nil?
  end

  def observe_friend_select
     observe_field( :friend,
                    :url => {:controller=>'gifts', :action=>'select_friend' }, 
                    #gets set in .rjs       :update => :li_sidebar,
                    :with => :friend, 
                    :on => :onselect
                  )
   end

end
