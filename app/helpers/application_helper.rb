# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper

  # use friends hash as basis for looking at friends' registries.
  def friend_registry_links
    select :key, :value, @user.friends.each {|k,v| [k,v] }, {:include_blank => true }   unless @user.nil?
  end

  def observe_friend_select
     observe_field( :friend,
                    :url => {:controller=>'gifts', :action=>'select_friend', :id=>@user.id}, 
                    #gets set in .rjs       :update => :li_sidebar,
                    :with => :friend, 
                    :on => :onchange
                  )
   end

end
