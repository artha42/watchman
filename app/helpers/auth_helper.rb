module AuthHelper
  def current_user_session
    return @current_user_session if defined?(@current_user_session)
    @current_user_session = UserSession.find
  end

  def current_user
    return @current_user if defined?(@current_user)
    @current_user = current_user_session && current_user_session.user
  end 

  def is_admin?
    if(current_user.email == "admin@starhealth.in")
      return true
    end
    admin_group=Group.find_by_name("admin")
    if(admin_group)
      if(admin_group.users.index(current_user))
        return true
      end
    end
    false
  end

end
