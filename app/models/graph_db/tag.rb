module GraphDB
  class Tag < GraphDB::Base
    # Define the properties of the Tag node
    # property :name, type: String, required: true
    # property :created_at, type: DateTime, default: -> { DateTime.now }
    # property :updated_at, type: DateTime, default: -> { DateTime.now }

    # # Define relationships
    # has_many :in, :questions, type: :TAGGED_IN, model_class: 'GraphDB::Question'
    # has_many :in, :answers, type: :TAGGED_IN, model_class: 'GraphDB::Answer'

    def all_tags
      self.class.all
    end

    def create_tag(data)
      self.class.create(data)
    end

    def get_tag(tag_id)
      self.class.find(tag_id)
    end

    def update_tag(tag_id, data)
      tag = get_tag(tag_id)
      tag.update(data) if tag
      tag
    end

    def delete_tag(tag_id)
      tag = get_tag(tag_id)
      tag.destroy if tag
    end

    def self.all_tags
      
    end
    def self.herarchey_tags(tag_id)
      
    end
  end
end