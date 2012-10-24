class RolesController < ApplicationController
  respond_to :html, :xml, :json
  
  before_filter :load_stage
  before_filter :load_host_choices, :only => [:new, :edit, :update, :create]
  before_filter :ensure_admin, :only => [:new, :edit, :destroy, :create, :update]

  # GET /projects/1/stages/1/roles/1
  # GET /projects/1/stages/1/roles/1.xml
  def show
    @role = @stage.roles.find(params[:id])

    respond_with(@role)
  end

  # GET /projects/1/stages/1/roles/new
  def new
    @role = @stage.roles.new
    respond_with(@role)
  end

  # GET /projects/1/stages/1/roles/1;edit
  def edit
    @role = @stage.roles.find(params[:id])
    respond_with(@role)
  end

  # POST /projects/1/stages/1/roles
  # POST /projects/1/stages/1/roles.xml
  def create
    @role = Role.unscoped.where(
      :name     => params[:role][:name],
      :host_id  => params[:role][:host_id],
      :stage_id => @stage.id
    ).first_or_create(params[:role].merge(:stage_id => @stage_id))

    if @role
      @role.tap { |r| r.deleted_at = nil }.save

      add_activity_for(@role, 'created')
      respond_with(@role, :location => [@project, @stage], :notice => 'Role was successfully created.')
    else
      respond_with(@role)
    end
  end

  # PUT /projects/1/stages/1/roles/1
  # PUT /projects/1/stages/1/roles/1.xml
  def update
    @role = @stage.roles.find(params[:id])

    if @role.update_attributes(params[:role])
      add_activity_for(@role, 'updated')
      flash[:notice] = 'Role was successfully updated.'
      respond_with(@role, :location => [@project, @stage])
    else
      respond_with(@role)
    end
  end

  # DELETE /projects/1/stages/1/roles/1
  # DELETE /projects/1/stages/1/roles/1.xml
  def destroy
    @role = @stage.roles.find(params[:id])
    @role.delete_logically_with_asscociation
    add_activity_for(@role, 'deleted')

    respond_with(@role, :location => [@project, @stage], :notice => 'Role was successfully deleted.')
  end

  protected
  def ensure_user_access
    if (current_user.stages.include?(@stage) && !current_user.read_only(@stage)) || ensure_admin
			return true
    else
      flash[:notice] = "Action not allowed"
      return false
    end
  end

  private
  def load_host_choices
    @host_choices = Host.order("name ASC").collect {|h| [ h.name, h.id ] }
  end
  
end
