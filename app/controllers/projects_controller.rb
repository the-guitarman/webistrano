class ProjectsController < ApplicationController
  before_filter :ensure_user, :only => [:show]


  before_filter :load_templates, :only => [:new, :create, :edit, :update]
  before_filter :ensure_admin, :only => [:new, :edit, :destroy, :create, :update]
  before_filter :ensure_user, :only => [:show]

  # GET /projects/dashboard
  def dashboard
    if self.current_user.admin?
      @deployments = Deployment.find(:all, :limit => 3, :order => 'created_at DESC')
    elsif !self.current_user.stage_ids.empty?
      @deployments = Deployment.find(:all, :conditions => ["stage_id IN (?)", self.current_user.stage_ids], :limit => 3, :order => 'created_at DESC')
    end

    respond_to do |format|
      format.html # dashboard.rhtml
    end
  end

  # GET /projects
  # GET /projects.xml
  def index
    @projects = self.current_user.admin? ? Project.find(:all, :order => 'name ASC') : self.current_user.projects

    respond_to do |format|
      format.html # index.rhtml
      format.xml  { render :xml => @projects.to_xml }
    end
  end

  # GET /projects/1
  # GET /projects/1.xml
  def show
    @project = Project.find(params[:id])

    respond_to do |format|
      format.html # show.rhtml
      format.xml  { render :xml => @project.to_xml }
    end
  end

  # GET /projects/new
  def new
    @project = Project.new
    if load_clone_original
      @project.prepare_cloning(@original)
      render :action => 'clone' and return
    end
  end

  # GET /projects/1;edit
  def edit
    @project = Project.find(params[:id])
  end

  # POST /projects
  # POST /projects.xml
  def create
    @project = Project.new(params[:project])

    if load_clone_original
      action_to_render = 'clone'
    else
      action_to_render = 'new'
    end

    respond_to do |format|
      if @project.save

        @project.clone(@original) if load_clone_original

        flash[:notice] = 'Project was successfully created.'
        format.html { redirect_to project_url(@project) }
        format.xml  { head :created, :location => project_url(@project) }
      else
        format.html { render :action => action_to_render }
        format.xml  { render :xml => @project.errors.to_xml }
      end
    end
  end

  # PUT /projects/1
  # PUT /projects/1.xml
  def update
    @project = Project.find(params[:id])

    respond_to do |format|
      if @project.update_attributes(params[:project])
        flash[:notice] = 'Project was successfully updated.'
        format.html { redirect_to project_url(@project) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @project.errors.to_xml }
      end
    end
  end

  # DELETE /projects/1
  # DELETE /projects/1.xml
  def destroy
    @project = Project.find(params[:id])
    @project.destroy

    respond_to do |format|
      flash[:notice] = 'Project was successfully deleted.'
      format.html { redirect_to projects_url }
      format.xml  { head :ok }
    end
  end

  protected

	        def ensure_user

	    		if  current_user.projects.include?( Project.find(params[:id])) || ensure_admin

	    			return true

	    		else

	      			flash[:notice] = "Action not allowed"

	      			return false

	    		end

		end


  def ensure_user
    if current_user.admin? || self.current_user.projects.include?(Project.find(params[:id]))
      true
    else
      flash[:notice] = "Action not allowed (not user)"
      false
    end
  end

  def load_templates
    @templates = ProjectConfiguration.templates.sort.collect do |k,v|
      [k.to_s.titleize, k.to_s]
    end

    @template_infos = ProjectConfiguration.templates.collect do |k,v|
      [k.to_s, v::DESC]
    end
  end

  def load_clone_original
    if params[:clone]
      @original = Project.find(params[:clone])
    else
      false
    end
  end
end
