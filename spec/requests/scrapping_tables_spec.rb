require 'swagger_helper'
# RAILS_ENV=test bundle exec rspec spec/requests/scrapping_tables_spec.rb

RSpec.describe 'ScrappingTables API', type: :request do
  path '/scrapping_tables' do
    post 'Create ScrappingTable' do
      tags 'ScrappingTable'
      consumes 'application/json'

      # parameter name: :scrapping_data,
      #           in: :body,
      #           schema: {
      #             '$ref' => '#/components/schemas/ScrappingTableCreateRequest'
      #           }
      parameter name: :scrapping_data,
          in: :body,
          schema: {
            type: :object,
            properties: {
              url: { type: :string, example: 'https://example.com' },
              workspace_id: { type: :integer, example: 42, default: 1 },
              # processing_status: {
              #   type: :string,
              #   enum: %w[unprocessed sp_filterer filtered sp_conveter conveter sp_convert final_response],
              #   example: 'unprocessed'
              # },
              request: {
                type: :object,
                properties: {
                  curl: { type: :string, example: 'curl -X GET https://example.com' }
                }
              }
            },
            required: ['url']
          }

      response '201', 'Created' do
        let(:scrapping_data) do
          {
            scrapping_data: {
              url: 'https://example.com',
              workspace_id: 42
            }
          }
        end
        run_test!
      end

      response '422', 'Validation failed' do
        let(:scrapping_data) do
          {
            scrapping_data: {
              url: ''
            }
          }
        end
        run_test!
      end
    end
  end
end
