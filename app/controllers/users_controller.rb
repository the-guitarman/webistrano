class UsersController < ApplicationController
  respond_to :html, :xml, :json
  
  before_filter :ensure_admin, :only => [:new, :destroy, :create, :enable]
  before_filter :ensure_admin_or_my_entry, :only => [:edit, :update]

  # GET /users
  # GET /users.xml
  def index
    @users = User.order('login ASC')
    respond_with(@users)
  end

  # GET /users/new
  def new
    @user = User.new
    respond_with(@user)
  end

  # POST /users
  # POST /users.xml
  def create
    @user = User.new(params[:user])

    if @user.save
      add_activity_for(@user, 'user.created')
      flash[:notice] = "Account created"
      respond_with(@user, :location => @user)
    else
      respond_with(@user)
    end
  end

  # GET /users/1
  # GET /users/1.xml
  def show
    @user = User.find(params[:id])
    @deployments = @user.deployments.recent
    respond_with(@user)
  end

  # GET /users/edit/1
  def edit
    @user = User.find(params[:id])
    respond_with(@user)
  end

  # PUT /users/1
  # PUT /users/1.xml
  def update
    @user = User.find(params[:id])

    unless current_user.admin?
      params[:user].delete(:admin)
    end

    if @user.update_attributes(params[:user])
      add_activity_for(@user, 'user.updated')
      flash[:notice] = 'User was successfully updated.'
      respond_with(@user, :location => @user)
    else
      respond_with(@user)
    end
  end

  # DELETE /users/1
  # DELETE /users/1.xml
  def destroy
    @user = User.find(params[:id])

    if @user.admin? && User.admins.count == 1
      flash[:notice] = 'Can not disable last admin user.'
    else
      @user.disable!
      flash[:notice] = 'User was successfully disabled.'
    end

    respond_with(@user)
  end

  def enable
    @user = User.find(params[:id])
    @user.enable!

    flash[:notice] = "The user was enabled"
    respond_with(@user, :location => users_path)
  end

  # GET /users/1/deployments
  # GET /users/1/deployments.xml
  def deployments
    @user = User.find(params[:id])
    @deployments = @user.deployments

    respond_with(@deployments)
  end

private
  
  def ensure_admin_or_my_entry
    if current_user.admin? || current_user.id == User.find(params[:id]).id
      return true
    else
      redirect_to root_url
      return false
    end
  end

end
