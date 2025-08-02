require 'swagger_helper'

RSpec.describe 'UserBookmarks API', type: :request do
  path '/user_bookmarks' do
    get 'List user bookmarks' do
      tags 'UserBookmarks'
      produces 'application/json'

      response '200', 'Bookmarks listed' do
        run_test!
      end
    end

    post 'Create a bookmark' do
      tags 'UserBookmarks'
      consumes 'application/json'
      parameter name: :user_bookmark, in: :body, schema: {
        type: :object,
        properties: {
          user_id: { type: :integer, example: 1 },
          bookmark_url: { type: :string, example: 'https://example.com' },
          title: { type: :string, example: 'Example Site' }
        },
        required: ['user_id', 'bookmark_url']
      }

      response '201', 'Bookmark created' do
        let(:user_bookmark) { { user_id: 1, bookmark_url: 'https://example.com', title: 'Example Site' } }
        run_test!
      end

      response '422', 'Invalid input' do
        let(:user_bookmark) { { user_id: nil, bookmark_url: '' } }
        run_test!
      end
    end
  end

  path '/user_bookmarks/{id}' do
    parameter name: :id, in: :path, type: :string, description: 'ID of the bookmark'

    get 'Get a bookmark' do
      tags 'UserBookmarks'
      produces 'application/json'

      response '200', 'Bookmark found' do
        let(:id) { UserBookmark.create(user_id: 1, bookmark_url: 'https://example.com').id }
        run_test!
      end

      response '404', 'Bookmark not found' do
        let(:id) { 'invalid' }
        run_test!
      end
    end

    patch 'Update a bookmark' do
      tags 'UserBookmarks'
      consumes 'application/json'
      parameter name: :user_bookmark, in: :body, schema: {
        type: :object,
        properties: {
          bookmark_url: { type: :string, example: 'https://new-link.com' },
          title: { type: :string, example: 'New Title' }
        }
      }

      response '200', 'Bookmark updated' do
        let(:id) { UserBookmark.create(user_id: 1, bookmark_url: 'https://example.com').id }
        let(:user_bookmark) { { title: 'Updated Title' } }
        run_test!
      end
    end

    delete 'Delete a bookmark' do
      tags 'UserBookmarks'

      response '204', 'Bookmark deleted' do
        let(:id) { UserBookmark.create(user_id: 1, bookmark_url: 'https://example.com').id }
        run_test!
      end
    end
  end
end
