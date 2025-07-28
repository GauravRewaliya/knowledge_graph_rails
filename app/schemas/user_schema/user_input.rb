
module UserSchema
  class UserInput
    def self.params
      { user: %i[name email password] }
    end

    def self.swagger_schema
      {
      type: :object,
      required: %w[name email password],
      properties: {
        user: {
        type: :object,
        required: %w[name email password],
        properties: {
          name: { type: :string, example: 'John' },
          email: { type: :string, example: 'john@example.com' },
          password: { type: :string, example: 'password123' }
        }
        }
      }
      }
    end
    end
end
