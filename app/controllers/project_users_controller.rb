class ProjectUsersController < ApplicationController

  before_filter :load_project
  before_filter :ensure_admin, :only => [:destroy, :create]

  def create
    @project_user = User.find params[:project_user][:id]
    current_project.users << @project_user unless current_project.user_ids.include?(@project_user.id)
    redirect_to project_url(current_project)
  end

  def destroy
    @project_user = User.find params[:id]
    current_project.users.delete @project_user if current_project.user_ids.include?(@project_user.id)
    redirect_to project_url(current_project)
  end

end
