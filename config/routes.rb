ActionController::Routing::Routes.draw do |map|
  
  map.login          "login", :controller => "user_sessions", :action => "new"
  map.logout         "logout", :controller => "user_sessions", :action => "destroy"
  map.signup         "signup", :controller => "user_sessions", :action => "new"
  
  map.invite         "invite", :controller => "users", :action => "invite"
  map.invitation     "invitation", :controller => "users", :action => "invitation"
  
  map.index_of_friend "index_of_friend", :controller => "gifts", :action => "index_of_friend"
  
  map.how            "how", :controller => "home", :action => "how"
  map.what           "what", :controller => "home", :action => "what"  
  map.faq            "faq", :controller => "home", :action => "faq"
  map.terms          "terms", :controller => "home", :action => "terms"  
  map.privacy        "privacy", :controller => "home", :action => "privacy"  
  map.tell           "tell", :controller => "home", :action => "tell"
  map.advertise      "advertise", :controller => "home", :action => "advertise"
  map.contact        "contact", :controller => "home", :action => "contact"
  
  
  map.resources :users, :has_many => [:registries, :roles, :gifts]
  map.resources :roles, :has_many => :users
  map.resources :registries
  map.resources :gifts, :has_many => :registries
  map.resources :user_sessions

  map.root :controller => "home"
  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
end
