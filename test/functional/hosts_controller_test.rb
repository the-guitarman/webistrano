require 'test_helper'

class HostsControllerTest < ActionController::TestCase
  def setup
    Host.delete_all
    @host = FactoryGirl.create(:host)
  end

  test "should_get_index" do
    @user = login

    get :index
    assert_response :success
    assert assigns(:hosts)
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

  test "non_admin_should_not_create_host" do
    @user = login

    old_count = Host.count
    post :create, :host => { :name => '192.168.0.1' }
    assert_equal old_count, Host.count

    assert_response :redirect
  end

  test "admin_should_create_host" do
    @user = admin_login

    old_count = Host.count
    post :create, :host => { :name => '192.168.0.1' }
    assert_equal old_count+1, Host.count

    assert_redirected_to host_path(assigns(:host))
  end

  test "activity_should_be_created_when_a_host_created" do
    @user = admin_login

    old_count = Activity.count
    post :create, :host => { :name => '192.168.0.1' }
    assert_equal old_count + 1, Activity.count

    activity = Activity.where('target_id = ? and target_type = "Host"', assigns(:host).id).first
    assert_not_nil activity
    assert_equal activity.tag, 'host.created'
  end

  test "should_show_host" do
    @user = login

    get :show, :id => @host.id
    assert_response :success
  end

  test "non_admin_should_not_get_edit" do
    @user = login

    get :edit, :id => @host.id
    assert_response :redirect
  end

  test "admin_should_get_edit" do
    @user = admin_login

    get :edit, :id => @host.id
    assert_response :success
  end

  test "non_admin_should_not_update_host" do
    @user = login

    put :update, :id => @host.id, :host => { :name => 'map.example.com' }
    assert_response :redirect
    @host.reload
    assert_not_equal 'map.example.com', @host.name
  end

  test "admin_should_update_host" do
    @user = admin_login

    put :update, :id => @host.id, :host => { :name => 'map.example.com' }
    assert_redirected_to host_path(assigns(:host))
    @host.reload
    assert_equal 'map.example.com', @host.name
  end

  test "activity_should_be_created_when_a_host_updated" do
    @user = admin_login

    old_count = Activity.count
    put :update, :id => @host.id, :host => { :name => 'map.example.com' }
    assert_equal old_count + 1, Activity.count

    activity = Activity.where('target_id = ? and target_type = "Host"', @host.id).first
    assert_not_nil activity
    assert_equal activity.tag, 'host.updated'
  end

  test "non_admin_should_not_destroy_host" do
    @user = login

    old_count = Host.count
    delete :destroy, :id => @host.id
    assert_equal old_count, Host.count

    assert_response :redirect
  end

  test "should_destroy_host" do
    @user = admin_login

    old_count = Host.count
    delete :destroy, :id => @host.id
    assert_equal old_count-1, Host.count

    assert_redirected_to hosts_path
  end
end
