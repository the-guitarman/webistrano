require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # Be sure to include AuthenticatedTestHelper in test/test_helper.rb instead.
  # Then, you can remove it from this and the functional test.
  fixtures :users

  test "should_create_user" do
    assert_difference 'User.count' do
      user = FactoryGirl.create(:user)
      assert !user.new_record?, "#{user.errors.full_messages.to_sentence}"
    end
  end

  test "admin" do
    user = FactoryGirl.create(:user)
    assert !user.admin?

    user.admin = 1
    assert user.admin?

    user.revoke_admin!
    assert !user.admin?

    user.make_admin!
    assert user.admin?
  end

  test "revert_admin_status_only_if_other_admins_left" do
    User.delete_all

    admin = FactoryGirl.create(:user)
    admin.make_admin!
    assert admin.admin?

    user = FactoryGirl.create(:user)
    assert !user.admin?

    # check that the admin status of admin cannot be taken
    assert_raise(ActiveRecord::RecordInvalid){
      admin.revoke_admin!
    }
  end

  test "recent_deployments" do
    user = FactoryGirl.create(:user)
    stage = FactoryGirl.create(:stage)
    role = FactoryGirl.create(:role, :stage => stage)
    5.times do
      deployment = FactoryGirl.create(:deployment, :stage => stage, :user => user)
    end

    assert_equal 5, user.deployments.count
    assert_equal 3, user.deployments.recent.length
    assert_equal 2, user.deployments.recent(2).length
  end

  test "disable" do
    user = FactoryGirl.create(:user)
    assert !user.disabled?

    user.disable!

    assert user.disabled?

    user.enable!

    assert !user.disabled?
  end

  test "disable_resets_remember_me" do
    user = FactoryGirl.create(:user)
    user.remember_me!

    assert_equal false, user.remember_expired?

    user.disable!
    user.reload

    assert user.remember_created_at.blank?
  end

  test "enabled_named_scope" do
    User.destroy_all
    assert_equal [], User.enabled
    assert_equal [], User.disabled

    user = FactoryGirl.create(:user)

    assert_equal [user], User.enabled
    assert_equal [], User.disabled

    user.disable!

    assert_equal [], User.enabled
    assert_equal [user], User.disabled
  end

end
