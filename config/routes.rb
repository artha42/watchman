ActionController::Routing::Routes.draw do |map|
  map.logout '/logout', :controller=>'user_sessions', :action=>'logout'
  map.resources :user_sessions
  map.resources :users
  map.resources :groups
  map.edit_role '/roles/:scope/:instance_id/:role', :controller=>'roles', :action=>'edit'
  map.show_roles '/roles/:scope/:instance_id', :controller=>'roles', :action=>'index'
  map.user_assign '/roles/assign/:scope/:instance_id/:role/to_user/:user_id', :controller=>'roles',:action=>'user_assign'
  map.user_revoke '/roles/revoke/:scope/:instance_id/:role/from_user/:user_id', :controller=>'roles',:action=>'user_revoke'
  map.group_assign '/roles/assign/:scope/:instance_id/:role/to_group/:group_id', :controller=>'roles',:action=>'group_assign'
  map.group_revoke '/roles/revoke/:scope/:instance_id/:role/from_group/:group_id', :controller=>'roles',:action=>'group_revoke'
  map.create_membership '/memberships/create/:group_id/:user_id', :controller=>'memberships', :action=>'create'
  map.destroy_membership 'memberships/destroy/:group_id/:user_id', :controller=>'memberships', :action=>'destroy'
end
