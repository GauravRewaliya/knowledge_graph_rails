require 'swagger_helper'

RSpec.describe 'Users API', type: :request do
  path '/users' do
    post 'Create user' do
      tags 'Users'
      consumes 'application/json'

      parameter name: :user, in: :body, schema: UserSchema::UserInput.swagger_schema()

      response '201', 'User created' do
        let(:user) do
          {
            user: {
              name: 'Jane',
              email: 'jane@example.com',
              password: 'password123',
            }
          }
        end

        schema UserSchema::UserOutput.swagger_schema()
        run_test!
      end
    end
  end

  path '/users/{id}' do
    get 'Get a user' do
      tags 'Users'
      produces 'application/json'
      parameter name: :id, in: :path, type: :string

      response '200', 'successful' do
        let!(:existing_user) { User.create!(name: 'John', email: 'john@example.com', password: '123456') }
        let(:id) { existing_user.id }

        schema UserSchema::UserOutput.swagger_schema()
        run_test!
      end
    end
  end
end
