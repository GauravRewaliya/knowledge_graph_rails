require 'swagger_helper'
RSpec.describe "/chat_sessions", type: :request do
  path '/workspaces/{workspace_id}/chatgpts/{chatgpt_id}/chat_sessions' do
    parameter name: :workspace_id, in: :path, type: :string, description: 'Workspace ID'
    parameter name: :chatgpt_id, in: :path, type: :string, description: 'ChatGPT ID'

    let(:workspace) { Workspace.create!(name: 'Test Workspace') }
    let(:chatgpt) { Chatgpt.create!(name: 'Test Bot', auth_token: 'abc123', workspace: workspace) }
    let(:chat_session) { ChatSession.create!(chatgpt: chatgpt, user_id: 1) }

    before do
      allow(ChatSession).to receive(:find).and_return(chat_session)
    end

    get 'Retrieves all chat sessions for a chatgpt' do
      tags 'Chat Sessions'
      produces 'application/json'

      response '200', 'chat sessions found' do
        let(:workspace_id) { workspace.id }
        let(:chatgpt_id) { chatgpt.id }

        run_test!
      end
    end

    post 'Creates a new chat session' do
      tags 'Chat Sessions'
      consumes 'application/json'
      parameter name: :chat_session, in: :body, schema: {
        type: :object,
        properties: {
          user_id: { type: :integer },
          messages: { type: :array, items: { type: :object } }
        },
        required: [ 'user_id' ]
      }

      response '201', 'chat session created' do
        let(:workspace_id) { workspace.id }
        let(:chatgpt_id) { chatgpt.id }
        let(:chat_session) do
          {
            user_id: 1,
            messages: []
          }
        end

        run_test!
      end

      response '422', 'invalid request' do
        let(:workspace_id) { workspace.id }
        let(:chatgpt_id) { chatgpt.id }
        let(:chat_session) { { user_id: nil } }

        run_test!
      end
    end

    describe "GET /index" do
      it "renders a successful response" do
        ChatSession.create! valid_attributes
        get chat_sessions_url, headers: valid_headers, as: :json
        expect(response).to be_successful
      end
    end

    describe "GET /show" do
      it "renders a successful response" do
        chat_session = ChatSession.create! valid_attributes
        get chat_session_url(chat_session), as: :json
        expect(response).to be_successful
      end
    end

    describe "POST /create" do
      context "with valid parameters" do
        it "creates a new ChatSession" do
          expect {
            post chat_sessions_url,
                params: { chat_session: valid_attributes }, headers: valid_headers, as: :json
          }.to change(ChatSession, :count).by(1)
        end

        it "renders a JSON response with the new chat_session" do
          post chat_sessions_url,
              params: { chat_session: valid_attributes }, headers: valid_headers, as: :json
          expect(response).to have_http_status(:created)
          expect(response.content_type).to match(a_string_including("application/json"))
        end
      end

      context "with invalid parameters" do
        it "does not create a new ChatSession" do
          expect {
            post chat_sessions_url,
                params: { chat_session: invalid_attributes }, as: :json
          }.to change(ChatSession, :count).by(0)
        end

        it "renders a JSON response with errors for the new chat_session" do
          post chat_sessions_url,
              params: { chat_session: invalid_attributes }, headers: valid_headers, as: :json
          expect(response).to have_http_status(:unprocessable_entity)
          expect(response.content_type).to match(a_string_including("application/json"))
        end
      end
    end

    describe "PATCH /update" do
      context "with valid parameters" do
        let(:new_attributes) {
          skip("Add a hash of attributes valid for your model")
        }

        it "updates the requested chat_session" do
          chat_session = ChatSession.create! valid_attributes
          patch chat_session_url(chat_session),
                params: { chat_session: new_attributes }, headers: valid_headers, as: :json
          chat_session.reload
          skip("Add assertions for updated state")
        end

        it "renders a JSON response with the chat_session" do
          chat_session = ChatSession.create! valid_attributes
          patch chat_session_url(chat_session),
                params: { chat_session: new_attributes }, headers: valid_headers, as: :json
          expect(response).to have_http_status(:ok)
          expect(response.content_type).to match(a_string_including("application/json"))
        end
      end

      context "with invalid parameters" do
        it "renders a JSON response with errors for the chat_session" do
          chat_session = ChatSession.create! valid_attributes
          patch chat_session_url(chat_session),
                params: { chat_session: invalid_attributes }, headers: valid_headers, as: :json
          expect(response).to have_http_status(:unprocessable_entity)
          expect(response.content_type).to match(a_string_including("application/json"))
        end
      end
    end

    describe "DELETE /destroy" do
      it "destroys the requested chat_session" do
        chat_session = ChatSession.create! valid_attributes
        expect {
          delete chat_session_url(chat_session), headers: valid_headers, as: :json
        }.to change(ChatSession, :count).by(-1)
      end
    end
  end
end
