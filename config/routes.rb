ActionController::Routing::Routes.draw do |map|
  
  map.login          "login", :controller => "user_sessions", :action => "new"
  map.logout         "logout", :controller => "user_sessions", :action => "destroy"
  map.signup         "signup", :controller => "user_sessions", :action => "new"

  map.resources :gifts  
  map.resources :users
  map.resources :user_sessions

  map.root :controller => "home"
  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
end
