require 'test_helper'

class ProjectsControllerTest < ActionController::TestCase

  def setup
    Project.delete_all
    @project = FactoryGirl.create(:project)
  end

  test "should_get_index" do
    @user = login

    get :index
    assert_response :success
    assert assigns(:projects)
  end

  test "non_admin_should_not_get_new" do
    @user = login

    get :new
    assert_response :redirect
  end

  test "admin_should_get_new" do
    @user = admin_login

    get :new
    assert_response :success
  end

  test "non_admin_should_not_create_project" do
    @user = login

    old_count = Project.count
    post :create, :project => { :name => 'Project Alpha', :template => 'rails'}
    assert_equal old_count, Project.count

    assert_response :redirect
  end

  test "admin_should_create_project" do
    @user = admin_login

    old_count = Project.count
    post :create, :project => { :name => 'Project Alpha', :template => 'rails'}
    assert_equal old_count+1, Project.count

    assert_redirected_to project_path(assigns(:project))

    assert_not_nil Project.find(:first).configuration_parameters.find_by_name('scm_username')
  end

  test "activity_should_be_created_when_a_project_created" do
    @user = admin_login

    old_count = Activity.count
    post :create, :project => { :name => 'Project Alpha', :template => 'rails'}
    assert_equal old_count + 1, Activity.count

    activity = Activity.where('target_id = ? and target_type = "Project"', assigns(:project).id).first
    assert_not_nil activity
    assert_equal activity.tag, 'project.created'
  end

  test "should_show_project" do
    @user = login

    get :show, :id => @project.id
    assert_response :success
  end

  test "non_admin_should_not_get_edit" do
    @user = login

    get :edit, :id => @project.id
    assert_response :redirect
  end

  test "admin_should_get_edit" do
    @user = admin_login

    get :edit, :id => @project.id
    assert_response :success
  end

  test "non_admin_should_not_update_project" do
    @user = login

    put :update, :id => @project.id, :project => { :name => 'Project Jochen', :template => 'mongrel_rails'}
    assert_response :redirect
    @project.reload
    assert_not_equal 'Project Jochen', @project.name
  end

  test "admin_should_update_project" do
    @user = admin_login

    put :update, :id => @project.id, :project => { :name => 'Project Jochen', :template => 'mongrel_rails'}
    assert_redirected_to project_path(assigns(:project))
    @project.reload
    assert_equal 'mongrel_rails', @project.template
  end

  test "activity_should_be_created_when_a_project_updated" do
    @user = admin_login

    old_count = Activity.count
    put :update, :id => @project.id, :project => { :name => 'Project Jochen', :template => 'mongrel_rails'}
    assert_equal old_count + 1, Activity.count

    activity = Activity.where('target_id = ? and target_type = "Project"', @project.id).first
    assert_not_nil activity
    assert_equal activity.tag, 'project.updated'
  end

  test "non_admin_should_not_destroy_project" do
    @user = login

    old_count = Project.count
    delete :destroy, :id => @project.id
    assert_equal old_count, Project.count

    assert_response :redirect
  end

  test "admin_should_destroy_project" do
    @user = admin_login

    old_count = Project.count
    delete :destroy, :id => @project.id
    assert_equal old_count-1, Project.count

    assert_redirected_to projects_path
  end

  test "clone" do
    @user = admin_login
    @project.template = "mod_rails"
    @project.save!
    assert_difference "Project.count", 1 do
      get :new, :clone => @project.id
      assert_response :success
      assert_select "h1", "Clone project"
      post :create, :clone => @project.id, :project => { :name => 'Project Alpha', :template => 'mongrel_rails'}
      assert_response :redirect
    end
  end
end
