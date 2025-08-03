class Workspaces::ChatSessionsController < ApplicationController
  before_action :set_workspace
  before_action :set_chatgpt
  before_action :set_chat_session, only: %i[ show update destroy ]

  # GET /chat_sessions
  def index
    @chat_sessions = ChatSession.all

    render json: @chat_sessions
  end

  # GET /chat_sessions/1
  def show
    render json: @chat_session
  end

  # POST /chat_sessions
  def create
    @chat_session = ChatSession.new(chat_session_params)

    if @chat_session.save
      render json: @chat_session, status: :created, location: @chat_session
    else
      render json: @chat_session.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /chat_sessions/1
  def update
    if @chat_session.update(chat_session_params)
      render json: @chat_session
    else
      render json: @chat_session.errors, status: :unprocessable_entity
    end
  end

  # DELETE /chat_sessions/1
  def destroy
    @chat_session.destroy!
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_chat_session
      @chat_session = ChatSession.find(params.expect(:id))
    end

    def set_chatgpt
      @chatgpt = Chatgpt.find(params.expect(:chatgpt_id))
    end

    def set_workspace
      @workspace = Workspace.first
    end

    # Only allow a list of trusted parameters through.
    def chat_session_params
      params.expect(chat_session: [ :name, :desc, :external_id, :meta_data, :last_used_at, :chatgpt_id, :workspace_id ])
    end
end
