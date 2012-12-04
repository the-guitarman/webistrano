require 'test_helper'

class StageConfigurationsControllerTest < ActionController::TestCase

  def setup
    @project = FactoryGirl.create(:project)
    @stage = FactoryGirl.create(:stage, :project => @project)
    @config = FactoryGirl.create(:stage_configuration, :stage => @stage)
    @user = login
  end

  test "should_get_new" do
    get :new, :project_id => @project.id, :stage_id => @stage.id
    assert_response :success
  end
  
  test "should_create_stage_configuration" do
    old_count = StageConfiguration.count
    post :create, :project_id => @project.id, :stage_id => @stage.id, :configuration => { :name => 'a', :value => 'b' }
    assert_equal old_count+1, StageConfiguration.count
    
    assert_redirected_to project_stage_path(@project, @stage)
  end

  test "should_get_edit" do
    get :edit, :project_id => @project.id, :stage_id => @stage.id, :id => @config.id
    assert_response :success
  end
  
  test "should_update_stage_configuration" do
    put :update, :project_id => @project.id, :stage_id => @stage.id, :id => @config.id, :configuration => { :name => 'a', :value => 'b'}
    assert_redirected_to project_stage_path(@project, @stage)
  end
  
  test "should_destroy_stage_configuration" do
    old_count = StageConfiguration.count
    delete :destroy, :project_id => @project.id, :stage_id => @stage.id, :id => @config.id
    assert_equal old_count-1, StageConfiguration.count
    
    assert_redirected_to project_stage_path(@project, @stage)
  end
end
