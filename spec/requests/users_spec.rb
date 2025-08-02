# spec/requests/users_spec.rb
require 'swagger_helper'

RSpec.describe 'Users API', type: :request do
  path '/users' do
    get 'List all users' do
      tags 'Users'
      produces 'application/json'

      response '200', 'OK' do
        run_test!
      end
    end

    post 'Create a user' do
      tags 'Users'
      consumes 'application/json'
      parameter name: :user, in: :body, schema: {
        type: :object,
        properties: {
          name: { type: :string, example: 'Alice' },
          email: { type: :string, format: :email, example: 'alice@example.com' },
          age: { type: :integer, example: 30 }
        },
        required: ['name', 'email']
      }

      response '201', 'User created' do
        let(:user) { { name: 'Alice', email: 'alice@example.com', age: 30 } }
        run_test!
      end

      response '422', 'Invalid input' do
        let(:user) { { name: '' } }
        run_test!
      end
    end
  end

  path '/users/{id}' do
    parameter name: :id, in: :path, type: :string

    get 'Show a user' do
      tags 'Users'
      produces 'application/json'

      response '200', 'User found' do
        let(:id) { User.create(name: 'Bob', email: 'bob@example.com').id }
        run_test!
      end

      response '404', 'User not found' do
        let(:id) { 'non-existent' }
        run_test!
      end
    end

    patch 'Update a user' do
      tags 'Users'
      consumes 'application/json'
      parameter name: :user, in: :body, schema: {
        type: :object,
        properties: {
          name: { type: :string },
          email: { type: :string, format: :email },
          age: { type: :integer }
        }
      }

      response '200', 'User updated' do
        let(:id) { User.create(name: 'Charlie', email: 'charlie@example.com').id }
        let(:user) { { name: 'Charlie Updated' } }
        run_test!
      end
    end

    delete 'Delete a user' do
      tags 'Users'

      response '204', 'User deleted' do
        let(:id) { User.create(name: 'Dave', email: 'dave@example.com').id }
        run_test!
      end
    end
  end
end
