class HostsController < ApplicationController
  respond_to :html, :xml, :json
  before_filter :ensure_admin, :only => [:new, :edit, :destroy, :create, :update]

  # GET /hosts
  # GET /hosts.xml
  def index
    @hosts = Host.find(:all, :order => 'name ASC')
    respond_with(@hosts)
  end

  # GET /hosts/1
  # GET /hosts/1.xml
  def show
    @host = Host.find(params[:id])

    # TODO - Why not in the model?
    @stages = @host.stages.uniq.sort_by{|x| x.project.name}

    respond_with(@host)
  end

  # GET /hosts/new
  def new
    @host = Host.new
    respond_with(@host)
  end

  # GET /hosts/1;edit
  def edit
    @host = Host.find(params[:id])
    respond_with(@host)
  end

  # POST /hosts
  # POST /hosts.xml
  def create
    @host = Host.unscoped.where(params[:host]).first_or_create

    if @host
      @host.tap { |h| h.deleted_at = nil }.save

      add_activity_for(@host, 'created')
      flash[:notice] = 'Host was successfully created.'
      respond_with(@host, :location => @host)
    else
      respond_with(@host)
    end
  end

  # PUT /hosts/1
  # PUT /hosts/1.xml
  def update
    @host = Host.find(params[:id])

    if @host.update_attributes(params[:host])
      add_activity_for(@host, 'updated')
      flash[:notice] = 'Host was successfully updated.'
      respond_with(@host, :location => @host)
    else
      respond_with(@host)
    end
  end

  # DELETE /hosts/1
  # DELETE /hosts/1.xml
  def destroy
    @host = Host.find(params[:id])
    @host.delete_logically_with_asscociation
    add_activity_for(@host, 'deleted')

    redirect_to hosts_path, :notice => 'Host was successfully deleted.'
  end
end
