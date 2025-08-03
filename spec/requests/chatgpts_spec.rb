require 'swagger_helper'

RSpec.describe 'ChatGPTs API', type: :request do
  path '/workspaces/{workspace_id}/chatgpts' do
    parameter name: :workspace_id, in: :path, type: :string, description: 'Workspace ID'

    get 'List all chatgpts' do
      tags 'ChatGPTs'
      produces 'application/json'

      response '200', 'chatgpt list fetched' do
        let(:workspace_id) { Workspace.create!(name: 'WS').id }

        before { Chatgpt.create!(name: 'Bot', auth_token: 'abc123', workspace_id: workspace_id) }

        run_test!
      end
    end

    post 'Create a chatgpt' do
      tags 'ChatGPTs'
      consumes 'application/json'
      parameter name: :chatgpt, in: :body, schema: {
        type: :object,
        properties: {
          name: { type: :string },
          desc: { type: :string },
          auth_token: { type: :string },
          meta_data: { type: :object },
          last_used_at: { type: :string, format: :date_time }
        },
        required: [ 'name', 'auth_token' ]
      }

      response '201', 'chatgpt created' do
        let(:workspace_id) { Workspace.create!(name: 'WS').id }
        let(:chatgpt) do
          {
            name: 'My Bot',
            auth_token: 'abc123',
            desc: 'A test bot',
            meta_data: { usage: 'testing' },
            last_used_at: Time.now.iso8601
          }
        end

        run_test!
      end

      response '422', 'invalid request' do
        let(:workspace_id) { Workspace.create!(name: 'WS').id }
        let(:chatgpt) { { name: '' } }

        run_test!
      end
    end
  end

  path '/workspaces/{workspace_id}/chatgpts/{id}' do
    parameter name: :workspace_id, in: :path, type: :string
    parameter name: :id, in: :path, type: :string

    get 'Retrieve a chatgpt' do
      tags 'ChatGPTs'
      produces 'application/json'

      response '200', 'chatgpt found' do
        let(:workspace_id) { Workspace.create!(name: 'WS').id }
        let(:id) { Chatgpt.create!(name: 'Bot', auth_token: 'abc123', workspace_id: workspace_id).id }

        run_test!
      end

      response '404', 'not found' do
        let(:workspace_id) { Workspace.create!(name: 'WS').id }
        let(:id) { 'invalid' }

        run_test!
      end
    end

    patch 'Update a chatgpt' do
      tags 'ChatGPTs'
      consumes 'application/json'
      parameter name: :chatgpt, in: :body, schema: {
        type: :object,
        properties: {
          name: { type: :string },
          desc: { type: :string }
        }
      }

      response '200', 'chatgpt updated' do
        let(:workspace_id) { Workspace.create!(name: 'WS').id }
        let(:id) { Chatgpt.create!(name: 'Bot', auth_token: 'abc123', workspace_id: workspace_id).id }
        let(:chatgpt) { { name: 'UpdatedBot' } }

        run_test!
      end
    end

    delete 'Delete a chatgpt' do
      tags 'ChatGPTs'

      response '204', 'chatgpt deleted' do
        let(:workspace_id) { Workspace.create!(name: 'WS').id }
        let(:id) { Chatgpt.create!(name: 'Bot', auth_token: 'abc123', workspace_id: workspace_id).id }

        run_test!
      end
    end
  end
end
