require File.dirname(__FILE__) + "/test_helper"
load_schema
class WatchmanPermissionsTest < ActiveSupport::TestCase
  include AuthHelper
  context "Given a user we" do
    setup do
      just_the_user
      @section=Section.create!(:name=>"test_section",
                               :description=>"Some long text")
    end
    should "be able to assign a role" do
      @section.assign :section_administrator, :to=>@user
      assert User.in_role?(:section_administrator, 
                           @section,
                           @user)
    end
  end
  
  context "Given a logged in user" do
    setup do
      login
      @document1 = Document.create!(:name=>"doc1")
      @document2 = Document.create!(:name=>"doc2")
    end
    context "Document 1" do
      setup do
        @document1.assign :owner, :to=>@user
      end
      should "have permissions" do
        assert @user.can?(:edit, @document1)
      end
    end
    context "Document 2" do
      setup do
      end
      should "not have permissions" do
        assert (not @user.can?(:edit, @document2))
      end
    end
  end

  context "Given a group" do
    setup do
      login
      setup_group
      @doc3 = Document.create!(:name=>"doc3")
      @doc3.assign :collaborator, :to=>@group
    end
    should "be able to share the document" do
      @user.can? :share, @doc3
    end
  end
end 
