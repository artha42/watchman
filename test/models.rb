class Document < ActiveRecord::Base

  has_roles :owner, :collaborator
  permit :owner, :to=>[:create,:edit,:destroy,:share]
  permit :collaborator, :to=>[:edit, :share]
  belongs_to :section
end

class Section < ActiveRecord::Base
  has_roles :section_administrator
  permit :section_administrator, :to=>[:upload, :manage]
  has_many :documents
end
