require File.dirname(__FILE__) + "/test_helper"
load_schema
class WatchmanExtensionsTest < ActiveSupport::TestCase
  context "given a bunch of users" do
    setup do
      @admin_user=User.new(:username => "admin",
                          :password => "test",
                          :password_confirmation => "test",
                          :email => "admin@domain.com")
      @admin_user.save!
      
      @admin_group = Group.new(:name => "admin")
      @admin_group.save!
      @user1 = User.new(:username => "test",
                       :password => "password",
                       :password_confirmation => "password",
                       :email => "normal@domain.com")
      @user1.save!
      @admin_group.users << @user1

      @user2 = User.new(:username => "test2",
                       :password => "password",
                       :password_confirmation => "password",
                       :email => "user2@domain.com")
      @user2.save!

    end
    should "assert admin_user as admin" do
      assert @admin_user.is_admin?
    end
    should "assert user1 as admin" do
      assert @user1.is_admin?
    end
    should "not assert user2 as admin" do
      assert (not @user2.is_admin?)
    end
  end
end
