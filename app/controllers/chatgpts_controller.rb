class Workspaces::ChatgptsController < ApplicationController
  before_action :set_workspace
  before_action :set_chatgpt, only: %i[ show update destroy ]

  # GET /chatgpts
  def index
    @chatgpts = @workspace.chatgpts
    render json: @chatgpts
  end

  # GET /chatgpts/1
  def show
    render json: @chatgpt
  end

  # POST /chatgpts
  def create
    @chatgpt = @workspace.chatgpts.build(chatgpt_params)

    if @chatgpt.save
      render json: @chatgpt, status: :created, location: @chatgpt
    else
      render json: @chatgpt.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /chatgpts/1
  def update
    if @chatgpt.update(chatgpt_params)
      render json: @chatgpt
    else
      render json: @chatgpt.errors, status: :unprocessable_entity
    end
  end

  # DELETE /chatgpts/1
  def destroy
    @chatgpt.destroy!
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_chatgpt
      @chatgpt = Chatgpt.find(params.expect(:id))
    end

    def set_workspace
      @workspace = Workspace.first # Workspace.find(params[:workspace_id])
    end

    # Only allow a list of trusted parameters through.
    def chatgpt_params
      params.expect(chatgpt: [ :name, :desc, :auth_token, :meta_data, :last_used_at, :workspace_id ])
    end
end
