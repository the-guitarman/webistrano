require 'non_transactional_test_helper'

class DeploymentTest < Test::Unit::TestCase
  
  def setup
    User.destroy_all
    Project.destroy_all
    Deployment.delete_all
  end
  
  test "locking_of_stage_through_lock_and_fire" do
    stage = FactoryGirl.create(:role, :name => 'app').stage
    assert !stage.locked?
    
    res = Deployment.lock_and_fire do |deployment|
      deployment.user  = FactoryGirl.create(:user)
      deployment.stage = stage
      deployment.task  = 'deploy'
    end
    
    stage.reload
    assert stage.locked?
    assert res
  end
  
  test "lock_and_fire_handles_transaction_abort" do
    stage = FactoryGirl.create(:role, :name => 'app').stage
    assert !stage.locked?
    res = Deployment.lock_and_fire do |deployment|
      deployment.user  = FactoryGirl.create(:user)
      deployment.stage = stage
      deployment.task  = 'deploy'
      deployment.expects(:save!).raises(ActiveRecord::RecordInvalid)
    end
    
    stage.reload
    assert !stage.locked?
    assert !res
  end
  
  test "lock_and_fire_sets_locking_deployment" do
    stage = FactoryGirl.create(:role, :name => 'app').stage
    assert !stage.locked?
    res = Deployment.lock_and_fire do |deployment|
      deployment.user  = FactoryGirl.create(:user, :login => 'MasterBlaster')
      deployment.stage = stage
      deployment.task  = 'deploy'
    end
    
    assert res
    stage.reload
    assert_not_nil stage.locking_deployment
    assert_equal Deployment.last, stage.locking_deployment
    assert_equal 'MasterBlaster', stage.locking_deployment.user.login
  end
  
  test "lock_and_fire_handles_transaction_abort_if_stage_breaks" do
    stage = FactoryGirl.create(:role, :name => 'app').stage
    assert !stage.locked?
    res = Deployment.lock_and_fire do |deployment|
      deployment.user  = FactoryGirl.create(:user)
      deployment.stage = stage
      deployment.task  = 'deploy'
      Stage.any_instance.stubs(:lock).raises(ActiveRecord::RecordInvalid)
    end
    
    stage.reload
    assert !stage.locked?
    assert !res
  end
  
end
