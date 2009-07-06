ActionController::Routing::Routes.draw do |map|
  map.logout '/logout', :controller=>'user_sessions', :action=>'logout'
  map.resources :user_sessions
  map.resources :users
  map.edit_role '/roles/:scope/:instance_id/:role', :controller=>'roles', :action=>'edit'
  map.show_roles '/roles/:scope/:instance_id', :controller=>'roles', :action=>'index'
  map.user_assign '/roles/assign/:scope/:instance_id/:role/to_user/:user_id', :controller=>'roles',:action=>'user_assign'
  map.user_revoke '/roles/revoke/:scope/:instance_id/:role/from_user/:user_id', :controller=>'roles',:action=>'user_revoke'
end
