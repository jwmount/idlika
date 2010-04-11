ActionController::Routing::Routes.draw do |map|
  
  map.login          "login", :controller => "user_sessions", :action => "new"
  map.logout         "logout", :controller => "user_sessions", :action => "destroy"
  map.signup         "signup", :controller => "user_sessions", :action => "new"
  map.how            "how", :controller => "home", :action => "how"
  map.what           "what", :controller => "home", :action => "what"  
  map.faq            "faq", :controller => "home", :action => "faq"
  map.terms          "terms", :controller => "home", :action => "terms"  
  map.privacy        "privacy", :controller => "home", :action => "privacy"  
  map.tell           "tell", :controller => "home", :action => "tell"
  map.advertise      "advertise", :controller => "home", :action => "advertise"
  map.contact        "contact", :controller => "home", :action => "contact"
  
  map.resources :gifts  
  map.resources :users
  map.resources :user_sessions

  map.root :controller => "home"
  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
end
