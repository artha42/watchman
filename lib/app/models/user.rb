class User < ActiveRecord::Base
  acts_as_authentic

  has_many :memberships
  has_many :groups, :through=>:memberships

  has_many :user_role_memberships
  has_many :roles, :through=>:user_role_memberships

  def self.in_role?(role,obj,userobj=nil)
    session = UserSession.find
    userobj ||= session.user
    if userobj.nil?
      raise Watchman::NoUserError, "No valid User"
    end
    userobj.in_role? role,obj
  end

  def in_role?(role,obj)
    scope=obj.class.name
    roleobj=Role.find_or_create_by_name_and_scope(:name=>role,:scope=>scope)
    if roleobj.users.index(self)
      return true
    end
    roleobj.groups.each do |group|
      if(group.users.index(self))
        return true
      end
    end
    false
  end

  def can?(permission,obj)
    if obj.nil?
      raise "Object to be compared is nil"
    end
    obj.class.permissions[permission].each do |role|
      if(self.in_role? role,obj)
        return true
      end
    end
    false
  end

end
