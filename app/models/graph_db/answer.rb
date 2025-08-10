module GraphDB
  class Answer < GraphDB::Base

    # Define the properties of the Answer node
    # property :text, type: String
    # property :created_at, type: DateTime, default: -> { DateTime.now }
    # property :updated_at, type: DateTime, default: -> { DateTime.now }

    # Define relationships
    # has_many :in, :questions, type: :ANSWERED_BY, model_class: 'GraphDB::Question'
    def all_questions
      
    end
    def create_question(data)
      
    end
    def get_question(question_id)
      
    end
    def update_question(question_id)
      
    end
    def delete_question(question_id)
      
    end

    def fetch_comments(question_id)
      
    end
    def fetch_answers(question_id)
      
    end
    def get_all_topics_herarchey(question_id)
      
    end
  end
end