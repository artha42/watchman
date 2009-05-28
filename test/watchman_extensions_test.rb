require File.dirname(__FILE__) + "/test_helper"
load_schema
class WatchmanExtensionsTest < ActiveSupport::TestCase
  context "ActiveRecord models" do
    should "respond to has_roles" do
      assert Document.respond_to?(:has_roles)
    end
    should "respond to permit" do
      assert Document.respond_to?(:permit)
    end
  end
  context "A Document" do
    should "have roles of owner and collaborator" do
      assert Document.roles.index(:owner)
      assert Document.roles.index(:collaborator)
    end
    should "be sharable by both owner and collaborator" do
      assert Document.permissions[:share].index(:owner)
      assert Document.permissions[:share].index(:collaborator)
    end
  end
end
