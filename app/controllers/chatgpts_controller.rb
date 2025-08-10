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

  # POST /chatgpts/import_from_curl
  def import_from_curl
    chatgpt_curl = params.expect(:chatgpt_curl)
    if chatgpt_curl.blank?
      render json: { error: "chatgpt_curl parameter is required" }, status: :unprocessable_entity
      return
    end
    auth_token = _retreave_auth_token(chatgpt_curl)
    if auth_token.blank?
      render json: { error: "Authorization token not found in chatgpt_curl" }, status: :unprocessable_entity
      return
    end
    request_params = {}
    request_params["name"] = params.name || "ChatGPT from cURL"
    request_params["desc"] = params.desc || "Imported from cURL"
    request_params["meta_data"] = params.meta_data || {}
    @chatgpt = ChatGpt.new(request_params)
    @chatgpt.auth_token = auth_token
    @chatgpt.workspace = @workspace
    if @chatgpt.save
      render json: @chatgpt, status: :created, location: @chatgpt
    else
      render json: @chatgpt.errors, status: :unprocessable_entity
    end
  end

  private

    def _retreave_auth_token(chatgpt_curl)
      request = CurlUtils.retreave_auth_token(chatgpt_curl)
      request[:headers].each do |header|
        if header[:name] == "Authorization"
          return header[:value]
        end
      end
      nil
    end

    def _retreave_from_har(chatgpt_har)
    end

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
