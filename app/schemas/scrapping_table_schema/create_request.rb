# app/schemas/scrapping_table_schema/create_request.rb
require_relative '../types'

module ScrappingTableSchema
  class CreateRequest < BaseSchema
    PROCESSING_STATUSES = ScrappingTable.processing_statuses.keys.freeze

    params do
      required(:url).filled(
        Types::String.meta(example: 'https://example.com')
      )

      optional(:workspace_id).value(
        Types::Integer.meta(example: 42, default: 1)
      )
      # optional(:processing_status).default('unprocessed').options(PROCESSING_STATUSES).example('filtered').type('enum')
      optional(:processing_status).value(
        Types::String.meta(
          type: :string,
          enum: PROCESSING_STATUSES,
          example: 'filtered',
          default: 'unprocessed'
        )
      )

      optional(:request).hash do
        required(:curl).filled(
          Types::String.meta(example: 'curl -X GET https://example.com')
        )
        required(:method).filled(
          Types::String.meta(example: 'GET', default: 'GET', options: %w[GET POST PUT DELETE])
        )
        optional(:headers).hash()
        optional(:params).hash()
        optional(:body).filled(
          Types::String.meta(example: '{"key": "value"}')
        )
      end
    end
  end
end