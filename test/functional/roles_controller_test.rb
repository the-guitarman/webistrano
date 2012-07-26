require 'test_helper'

class RolesControllerTest < ActionController::TestCase

  def setup
    @project = FactoryGirl.create(:project)
    @stage = FactoryGirl.create(:stage, :project => @project)
    @host = FactoryGirl.create(:host)
    @role = FactoryGirl.create(:role, :stage => @stage, :host => @host)
    @user = login
  end

  test "should_get_new" do
    get :new, :project_id => @project.id, :stage_id => @stage.id
    assert_response :success
  end

  test "should_create_role" do
    old_count = Role.count
    post :create, :project_id => @project.id, :stage_id => @stage.id, :role => { :name => 'a', :value => 'b', :host_id => @host.id }
    assert_equal old_count+1, Role.count

    assert_redirected_to project_stage_path(@project, @stage)
  end

  test "activity_should_be_created_when_a_role_created" do
    old_count = Activity.count
    post :create, :project_id => @project.id, :stage_id => @stage.id, :role => { :name => 'a', :value => 'b', :host_id => @host.id }
    assert_equal old_count + 1, Activity.count

    activity = Activity.where('target_id = ? and target_type = "Role"', assigns(:role).id).first
    assert_not_nil activity
    assert_equal activity.tag, 'role.created'
  end

  test "should_get_edit" do
    get :edit, :project_id => @project.id, :stage_id => @stage.id, :id => @role.id
    assert_response :success
  end

  test "should_update_role" do
    put :update, :project_id => @project.id, :stage_id => @stage.id, :id => @role.id, :role => { :name => 'a', :value => 'b', :host_id => @host.id}
    assert_redirected_to project_stage_path(@project, @stage)
  end

  test "activity_should_be_created_when_a_role_updated" do
    old_count = Activity.count
    put :update, :project_id => @project.id, :stage_id => @stage.id, :id => @role.id, :role => { :name => 'a', :value => 'b', :host_id => @host.id}
    assert_equal old_count + 1, Activity.count

    activity = Activity.where('target_id = ? and target_type = "Role"', @role.id).first
    assert_not_nil activity
    assert_equal activity.tag, 'role.updated'
  end

  test "should_destroy_role" do
    old_count = Role.count
    delete :destroy, :project_id => @project.id, :stage_id => @stage.id, :id => @role.id
    assert_equal old_count-1, Role.count

    assert_redirected_to project_stage_path(@project, @stage)
  end
end
