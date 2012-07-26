class ApplicationController < ActionController::Base
  before_filter :authenticate_user!
  before_filter :ensure_not_disabled
  around_filter :set_timezone

  layout 'application'

  helper :all # include all helpers, all the time
  helper_method :current_stage, :current_project

  # See ActionController::RequestForgeryProtection for details
  # Uncomment the :secret if you're not using the cookie session store
  protect_from_forgery

  protected

  def set_timezone
    # default timezone is UTC
    Time.zone = user_signed_in? ? ( current_user.time_zone rescue 'UTC'): 'UTC'
    yield
    Time.zone = 'UTC'
  end

  def load_project
    @project = Project.find(params[:project_id])
  end

  def load_stage
    load_project
    @stage = @project.stages.find(params[:stage_id])
  end

  def current_stage
    @stage
  end

  def current_project
    @project
  end

  def ensure_admin
    if user_signed_in? && current_user.admin?
      return true
    else
      flash[:notice] = "Action not allowed"
      redirect_to root_path
      return false
    end
  end

  def ensure_not_disabled
    if user_signed_in? && current_user.disabled?
      sign_out_all_scopes
      redirect_to root_path
      return false
    else
      return true
    end
  end

  def add_activity_for(target, tag, data = {})
    data['changes'] = target.previous_changes.keep_if{ |k,v| k !~ /_at$/ }
    target.activities.create(user_id: current_user.id, tag: tag, data: data)
  end
end
