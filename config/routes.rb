ActionController::Routing::Routes.draw do |map|


  
  map.login          "login", :controller => "user_sessions", :action => "new"
  map.logout         "logout", :controller => "user_sessions", :action => "destroy"
  map.signup         "signup", :controller => "user_sessions", :action => "new"
  map.orient         "orient", :controller => "user_sessions", :action => "orient"
  
  map.invite         "invite", :controller => "users", :action => "invite"
  map.invitation     "invitation", :controller => "users", :action => "invitation"
  map.accept_invite  "accept_invite", :controller => "users", :action => "accept_invite"
  
  map.friend             "friend",             :controller => "gifts", :action => "friend"
  map.select_friend      "select_friend",      :controller => "gifts", :action => "select_friend"
  map.index_for_friend   "index_for_friend",   :controller => "gifts", :action => "index_for_friend"
  map.index_for_registry "index_for_registry", :controller => "gifts", :action => "index_for_registry"
  map.gift_restore_owner "gift_restore_owner", :controller => "gifts", :action => "restore_owner"
  map.give_gift          "give_gift",          :controller => "gifts", :action => "give_gift"
  map.copy_gift          "copy_gift",          :controller => "gifts", :action => "copy_gift"

    
  map.how            "how",       :controller => "home", :action => "how"
  map.what           "what",      :controller => "home", :action => "what"  
  map.faq            "faq",       :controller => "home", :action => "faq"
  map.terms          "terms",     :controller => "home", :action => "terms"  
  map.privacy        "privacy",   :controller => "home", :action => "privacy"  
  map.tell           "tell",      :controller => "home", :action => "tell"
  map.advertise      "advertise", :controller => "home", :action => "advertise"
  map.contact        "contact",   :controller => "home", :action => "contact"

  map.resources :donors
  map.resources :gifts, :has_many => :donors, :has_many => :sources
  map.resources :registries, :has_many => :gifts
  map.resources :roles, :has_many => :users
  map.resources :sources
  map.resources :user_sessions
  map.resources :users, :has_many => [:registries, :roles, :gifts, :friends]

  map.resources :clubs, :has_many => :events

  map.root :controller => "home"
  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
end
