class Group < ActiveRecord::Base
  has_many :memberships
  has_many :users, :through=>:memberships

  has_many :group_role_memberships
  has_many :roles, :through=>:group_role_memberships

  validates_uniqueness_of :name
end
