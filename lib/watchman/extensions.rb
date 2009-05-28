module Watchman
  module ActiveRecord
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
      def assign(role,options={})
        if not options.has_key?(:to)
          return
        end
        role=Role.find_or_create_by_name_and_scope(role,self.class.name)
        if options[:to].instance_of?(Group)
          role.groups << options[:to]
        end
        if options[:to].instance_of?(User)
          role.users << options[:to]
        end
      end
    end
  end
end
class ActiveRecord::Base
  class << self
    attr_accessor :roles, :permissions
  end
end
ActiveRecord::Base.send :include, Watchman::ActiveRecord
