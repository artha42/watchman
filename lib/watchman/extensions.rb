module Watchman
  def self.included(base)
    base.send :extend, ClassMethods
    base.send :include, InstanceMethods
  end
  module ClassMethods
    def has_roles(*roles)
      @roles=roles
    end
    def permit(role,options={})
      if not options.has_key?(:to)
        return
      end
      @permissions ||= {}
      options[:to].each do |permission|
        @permissions[permission] ||= []
        @permissions[permission] << role
      end
    end
  end
  
  module InstanceMethods
    def check_permission(permission, user=nil)
      user ||= UserSession.find
      if user.nil?
        raise Watchman::NoUserError.new, "No User found"
      end 
      
    end
    def if_authorized(options)

    end
  end
end
class ActiveRecord::Base
  class << self
    attr_accessor :roles, :permissions
  end
end
ActiveRecord::Base.send :include, Watchman
