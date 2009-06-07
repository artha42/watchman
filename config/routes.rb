ActionController::Routing::Routes.draw do |map|
  map.logout '/logout', :controller=>'user_sessions', :action=>'logout'
  map.resources :user_sessions
  map.resources :users
end
