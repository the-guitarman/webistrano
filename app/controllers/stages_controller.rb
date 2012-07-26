class StagesController < ApplicationController
  respond_to :html, :xml, :json

  before_filter :load_project

  # GET /projects/1/stages.xml
  def index
    @stages = current_project.stages
    respond_with(@stages)
  end

  # GET /projects/1/stages/1
  # GET /projects/1/stages/1.xml
  def show
    @stage = current_project.stages.find(params[:id])
    @task_list = [['All tasks: ', '']] + @stage.list_tasks.collect{|task| [task[:name], task[:name]]}.sort()
    respond_with(@stage)
  end

  # GET /projects/1/stages/new
  def new
    @stage = current_project.stages.new
    respond_with(@stage)
  end

  # GET /projects/1/stages/1;edit
  def edit
    @stage = current_project.stages.find(params[:id])
    respond_with(@stage)
  end

  # GET /projects/1/stages/1/tasks
  # GET /projects/1/stages/1/tasks.xml
  def tasks
    @stage = current_project.stages.find(params[:id])
    @tasks = @stage.list_tasks

    respond_with(@tasks)
  end

  # POST /projects/1/stages
  # POST /projects/1/stages.xml
  def create
    @stage = current_project.stages.build(params[:stage])

    if @stage.save
      add_activity_for(@stage, 'stage.created')
      flash[:notice] = 'Stage was successfully created.'
      respond_with(@stage, :location => [current_project, @stage])
    else
      respond_with(@stage)
    end
  end

  # PUT /projects/1/stages/1
  # PUT /projects/1/stages/1.xml
  def update
    @stage = current_project.stages.find(params[:id])

    if @stage.update_attributes(params[:stage])
      add_activity_for(@stage, 'stage.updated')
      flash[:notice] = 'Stage was successfully updated.'
      respond_with(@stage, :location => [current_project, @stage])
    else
      respond_with(@stage)
    end
  end

  # DELETE /projects/1/stages/1
  # DELETE /projects/1/stages/1.xml
  def destroy
    @stage = current_project.stages.find(params[:id])
    @stage.destroy

    flash[:notice] = 'Stage was successfully deleted.'
    respond_with(@stage, :location => current_project)
  end

  # GET /projects/1/stages/1/capfile
  # GET /projects/1/stages/1/capifile.xml
  def capfile
    @stage = current_project.stages.find(params[:id])

    respond_with(@stage) do |format|
      format.text do
        send_file_headers! \
               :disposition  => "attachment",
               :filename     => 'Capfile.rb'
        render :layout       => false,
               :content_type => 'text/plain'
      end
    end
  end

  # GET | PUT /projects/1/stages/1/recipes
  # GET /projects/1/stages/1/recipes.xml
  def recipes
    @stage = current_project.stages.find(params[:id])
    if request.put?
      @stage.recipe_ids = params[:stage][:recipe_ids] rescue []
      flash[:notice] = "Stage recipes successfully updated."
      redirect_to project_stage_url(current_project, @stage)
    else
      respond_to do |format|
        format.html { render }
        format.xml  { render :xml => @stage.recipes.to_xml }
      end
    end
  end

end
