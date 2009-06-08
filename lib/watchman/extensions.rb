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
          if GroupRoleMembership.find(:first,
                                      :conditions => ["role_id=? and group_id=? and instance_id=?", role.id, options[:to].id,self.id])
            return
          end
          grm=role.group_role_memberships.build
          grm.group = options[:to]
          grm.instance_id = self.id
          grm.save
        end
        if options[:to].instance_of?(User)
          if UserRoleMembership.find(:first,
                                      :conditions => ["role_id=? and user_id=? and instance_id=?", role.id, options[:to].id,self.id])
            logger.info "Record found. Not creating an new one"
            return
          end 
          urm=role.user_role_memberships.build
          urm.user_id = options[:to].id
          urm.instance_id=self.id
          urm.save
          logger.info "done saving a role"
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
