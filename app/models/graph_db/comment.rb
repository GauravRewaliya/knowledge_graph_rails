module GraphDB
  class Comment < GraphDB::Base

    # Define the properties of the Comment node
    # property :user_id, type: String # hashid of user
    # property :source_metadata, type: JSON # metadata about the source of the comment
    # property :parent_comment_id, type: String, optional: true # hashid of the parent comment if this is a reply

    # property :text, type: String
    # property :created_at, type: DateTime, default: -> { DateTime.now }
    # property :updated_at, type: DateTime, default: -> { DateTime.now }

    # Define relationships
    # belongs_to :linkable_post, polymorphic: true
    #   - question || answer || other post types
    def create_comment(data)
      
    end
    def update_comment(comment_id)
      
    end
    def all_comments(post_id)
      
    end
    def delete_comment(comment_id)
      
    end
  end
end
# todo: Like Dislike