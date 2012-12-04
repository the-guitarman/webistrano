require 'test_helper'

class RecipesControllerTest < ActionController::TestCase

  def setup
    @recipe = FactoryGirl.create(:recipe)
  end

  test "should_get_index" do
    @user = login
    
    get :index
    assert_response :success
    assert assigns(:recipes)
  end

  test "non_admin_should_not_get_new" do
    @user = login
    assert !@user.admin?
    
    get :new
    assert_response :redirect
  end
  
  test "admin_should_not_new" do
    @user = admin_login
    assert @user.admin?
    
    get :new
    assert_response :success
  end
  
  test "non_admin_should_not_create_recipe" do
    @user = login
    
    old_count = Recipe.count
    post :create, :recipe => { :name => 'Copy Config files', :body => 'foobarr'}
    assert_equal old_count, Recipe.count
    
    assert_response :redirect
  end
  
  test "admin_should_create_recipe" do
    @user = admin_login
    
    old_count = Recipe.count
    post :create, :recipe => { :name => 'Copy Config files', :body => 'foobarr'}
    assert_equal old_count+1, Recipe.count
    
    assert_redirected_to recipe_path(assigns(:recipe))
  end

  test "should_show_recipe" do
    @user = login
    
    get :show, :id => @recipe.id
    assert_response :success
  end

  test "non_admin_should_not_get_edit" do
    @user = login
    
    get :edit, :id => @recipe.id
    assert_response :redirect
  end
  
  test "admin_should_get_edit" do
    @user = admin_login
    
    get :edit, :id => @recipe.id
    assert_response :success
  end
  
  test "non_admin_should_not_update_recipe" do
    @user = login
    
    put :update, :id => @recipe.id, :recipe => {:name => 'foobarr 22'}
    assert_response :redirect
    @recipe.reload 
    
    assert_not_equal 'foobarr 22', @recipe.name
  end
  
  test "admin_should_update_recipe" do
    @user = admin_login
    
    put :update, :id => @recipe.id, :recipe => {:name => 'foobarr 22'}
    assert_redirected_to recipe_path(assigns(:recipe))
    @recipe.reload 
    
    assert_equal 'foobarr 22', @recipe.name
  end
  
  test "non_admin_should_not_destroy_recipe" do
    @user = login
    
    old_count = Recipe.count
    delete :destroy, :id => @recipe
    assert_equal old_count, Recipe.count
    
    assert_response :redirect
  end
  
  test "admin_should_destroy_recipe" do
    @user = admin_login
    
    old_count = Recipe.count
    delete :destroy, :id => @recipe
    assert_equal old_count-1, Recipe.count
    
    assert_redirected_to recipes_path
  end
  
  test "should_preview_the_recipe" do
    @user = admin_login
    
    xhr :get, :preview, :recipe => {:body => @recipe.body}
    assert_select_rjs :replace_html, "preview"
  end

  test "show_with_version_should_show_the_specified_version" do
    @user = admin_login
    
    @recipe.update_attributes!(:body => "do_something :else")
    @recipe.update_attributes!(:body => "do_something :other_than => :else")
    get :show, :id => @recipe.id, :version => 2
    assert_equal "do_something :else", assigns["recipe"].body
  end
  
  test "edit_with_version_should_load_the_specified_version" do
    @user = admin_login
    @recipe.update_attributes!(:body => "do_something :else")
    @recipe.update_attributes!(:body => "do_something :other_than => :else")
    get :edit, :id => @recipe.id, :version => 2
    assert_equal "do_something :else", assigns["recipe"].body
  end
  
  test "show_should_ignore_illegal_versions" do
    @user = admin_login
    
    @recipe.update_attributes!(:body => "do_something :else")
    @recipe.update_attributes!(:body => "do_something :other_than => :else")
    get :show, :id => @recipe.id, :version => @recipe.version + 1
    assert_equal "do_something :other_than => :else", assigns["recipe"].body
  end
end
