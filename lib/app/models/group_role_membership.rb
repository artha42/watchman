class GroupRoleMembership < ActiveRecord::Base
  belongs_to :group
  belongs_to :role

  validates_uniqueness_of :group_id, :scope => :role_id
end
