class User < ActiveRecord::Base
  acts_as_authentic

  has_many :memberships
  has_many :groups, :through=>:memberships

  has_many :user_role_memberships
  has_many :roles, :through=>:user_role_memberships

end
