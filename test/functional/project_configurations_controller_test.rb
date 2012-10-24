require 'test_helper'

class ProjectConfigurationsControllerTest < ActionController::TestCase

  def setup
    @project = FactoryGirl.create(:project)
    @config  = FactoryGirl.create(:project_configuration, :project => @project)
    @user = login
  end

  test "should_get_new" do
    get :new, :project_id => @project.id
    assert_response :success
  end
  
  test "should_create_project_configuration" do
    old_count = ProjectConfiguration.count
    post :create, :project_id => @project.id, :configuration => { :name => 'a', :value => 'b' }
    assert_equal old_count+1, ProjectConfiguration.count
    
    assert_redirected_to project_path(@project)
  end

  test "should_get_edit" do
    get :edit, :project_id => @project.id, :id => @config.id
    assert_response :success
  end
  
  test "should_update_project_configuration" do
    put :update, :project_id => @project.id, :id => @config.id, :configuration => { :name => 'a', :value => 'b'}
    assert_redirected_to project_path(@project)
  end
  
  test "should_destroy_project_configuration" do
    old_count = ProjectConfiguration.count
    delete :destroy, :project_id => @project.id, :id => @config.id
    assert_equal old_count-1, ProjectConfiguration.count
    
    assert_redirected_to project_path(@project)
  end
end
