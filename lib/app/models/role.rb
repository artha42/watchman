class Role < ActiveRecord::Base
  validates_uniqueness_of :name, :scope => :scope
end
