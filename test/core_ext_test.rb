require 'test_helper'
load_schema
class CoreExtTest < ActiveRecord::TestCase
  context "ActiveRecord Extensions" do
    setup do
      class Document < ActiveRecord::Base

      end
    end
    should "respond to has_roles" do
      assert Document.respond_to?(:has_roles)
    end
  end
end
