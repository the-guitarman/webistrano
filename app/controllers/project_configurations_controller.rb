class ProjectConfigurationsController < ApplicationController
  respond_to :html, :xml, :json
  before_filter :load_project

  # GET /projects/1/project_configurations/1
  # GET /projects/1/project_configurations/1.xml
  def show
    @configuration = current_project.configuration_parameters.find(params[:id])
    respond_with(@configuration)
  end

  # GET /projects/1/project_configurations/new
  def new
    @configuration = current_project.configuration_parameters.new
    respond_with(@configuration)
  end

  # GET /projects/1/project_configurations/1;edit
  def edit
    @configuration = current_project.configuration_parameters.find(params[:id])
    respond_with(@configuration)
  end

  # POST /projects/1/project_configurations
  # POST /projects/1/project_configurations.xml
  def create
    @configuration = current_project.configuration_parameters.build(params[:configuration])

    if @configuration.save
      flash[:notice] = 'ProjectConfiguration was successfully created.'
      respond_with(@configuration, :location => current_project)
    else
      respond_with(@configuration)
    end
  end

  # PUT /projects/1/project_configurations/1
  # PUT /projects/1/project_configurations/1.xml
  def update
    @configuration = current_project.configuration_parameters.find(params[:id])

    if @configuration.update_attributes(params[:configuration])
      flash[:notice] = 'ProjectConfiguration was successfully updated.'
      respond_with(@configuration, :location => current_project)
    else
      respond_with(@configuration)
    end
  end

  # DELETE /projects/1/project_configurations/1
  # DELETE /projects/1/project_configurations/1.xml
  def destroy
    @configuration = current_project.configuration_parameters.find(params[:id])
    @configuration.destroy

    flash[:notice] = 'ProjectConfiguration was successfully deleted.'
    respond_with(@configuration, :location => current_project)
  end
end
