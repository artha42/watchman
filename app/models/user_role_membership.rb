class UserRoleMembership < ActiveRecord::Base
  belongs_to :user
  belongs_to :role
  validates_uniqueness_of :role_id, :scope => [:user_id, :instance_id]
end
