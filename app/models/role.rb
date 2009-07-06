class Role < ActiveRecord::Base
  has_many :user_role_memberships
  has_many :group_role_memberships
  has_many :users, :through => :user_role_memberships
  has_many :groups, :through => :group_role_memberships
  validates_uniqueness_of :name, :scope => [:scope, :instance_id]
end
