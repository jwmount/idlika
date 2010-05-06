ActionController::Routing::Routes.draw do |map|
  map.resources :items

  map.resources :descriptions

  
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

  map.resources :users, :has_many => [:registries, :roles, :gifts]
  map.resources :roles, :has_many => :users
  map.resources :registries, :has_many => :items
  map.resources :gifts, :has_one => :description, :has_many => :items
  map.resources :descriptions
  map.resources :items
  
  map.resources :user_sessions

  map.root :controller => "home"
  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
end
