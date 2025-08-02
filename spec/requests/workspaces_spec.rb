# spec/requests/workspaces_spec.rb
require 'swagger_helper'

RSpec.describe 'Workspaces API', swagger_doc: 'v1/swagger.yaml', type: :request do
  path '/workspaces' do
    get 'List workspaces' do
      tags 'Workspaces'
      produces 'application/json'

      response '200', 'workspaces listed' do
        run_test!
      end
    end

    post 'Create workspace' do
      tags 'Workspaces'
      consumes 'application/json'
      parameter name: :workspace, in: :body, schema: {
        type: :object,
        properties: {
          name: { type: :string, example: 'My Workspace' }
        },
        required: ['name']
      }

      response '201', 'workspace created' do
        let(:workspace) { { name: 'My Workspace' } }
        run_test!
      end

      response '422', 'invalid request' do
        let(:workspace) { { name: '' } }
        run_test!
      end
    end
  end

  path '/workspaces/{id}' do
    parameter name: :id, in: :path, type: :string, description: 'Workspace ID'

    get 'Show workspace' do
      tags 'Workspaces'
      produces 'application/json'
      response '200', 'found' do
        let(:id) { Workspace.create!(name: 'Temp').id }
        run_test!
      end
    end

    patch 'Update workspace' do
      tags 'Workspaces'
      consumes 'application/json'
      parameter name: :workspace, in: :body, schema: {
        type: :object,
        properties: {
          name: { type: :string, example: 'Updated Name' }
        }
      }

      response '200', 'updated' do
        let(:id) { Workspace.create!(name: 'Temp').id }
        let(:workspace) { { name: 'Updated Name' } }
        run_test!
      end
    end

    delete 'Delete workspace' do
      tags 'Workspaces'
      response '204', 'deleted' do
        let(:id) { Workspace.create!(name: 'Temp').id }
        run_test!
      end
    end
  end
end
