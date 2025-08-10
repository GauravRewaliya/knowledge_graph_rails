class WorkspacesController < ApplicationController
  before_action :set_workspace, only: %i[ show update destroy ]

  # GET /workspaces
  def index
    @workspaces = Workspace.all

    render json: @workspaces
  end

  # GET /workspaces/1
  def show
    render json: @workspace
  end

  # POST /workspaces
  def create
    @workspace = Workspace.new({ user_id: current_user.id, **workspace_params })

    if @workspace.save
      render json: @workspace, status: :created, location: @workspace
    else
      render json: @workspace.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /workspaces/1
  def update
    if @workspace.update(workspace_params)
      render json: @workspace
    else
      render json: @workspace.errors, status: :unprocessable_entity
    end
  end

  # DELETE /workspaces/1
  def destroy
    @workspace.destroy!
  end

  # GET /view/workspaces
  def workspace_index
    @workspaces = Workspace.all
    render 'workspaces/index'
  end

  # GET /view/workspaces/:workspace_id/swagger
  def workspace_swagger
    @workspace = Workspace.find(params[:workspace_id])
    render 'workspaces/show'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_workspace
      @workspace = Workspace.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def workspace_params
      params.expect(workspace: [ :name, :user_id ])
    end
end
