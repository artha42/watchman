module AuthHelper
  def current_user_session
    return @current_user_session if defined?(@current_user_session)
    @current_user_session = UserSession.find
  end

  def current_user
    return @current_user if defined?(@current_user)
    @current_user = current_user_session && current_user_session.user
  end 

  def render_permissions(obj,role)
    role_obj=Role.find_or_create_by_name_and_scope_and_instance_id(role,obj.class.name,obj.id)
    role_obj.save
    render :partial=>'roles/edit', :locals=>{:role=>role_obj, :obj=>obj}
  end
end
