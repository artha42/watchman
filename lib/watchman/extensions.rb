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
      def revoke(role,options={})
        if not options.has_key?(:from)
          return
        end
        role=Role.find_or_create_by_name_and_scope_and_instance_id(role.to_s,self.class.name,self.id)
        if options[:from].instance_of?(Group)
          if(role.groups.index(options[:from]))
             role.groups.delete options[:from]
             return options[:from]
          else
            return options[:from]
          end
        end
        if options[:from].instance_of?(User)
          if(role.users.index(options[:from]))
            role.users.delete options[:from]
            return options[:from]
          else
            return options[:from]
          end 
        end
      end
      def assign(role,options={})
        if not options.has_key?(:to)
          return
        end
        role=Role.find_or_create_by_name_and_scope_and_instance_id(role.to_s,self.class.name,self.id)
        if options[:to].instance_of?(Group)
          if(not role.groups.index(options[:to]))
             role.groups << options[:to]
             return options[:to]
          else
            return options[:to]
          end
        end
        if options[:to].instance_of?(User)
          if(not role.users.index(options[:to]))
            role.users << options[:to]
            return options[:to]
          else
            return options[:to]
          end 
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
