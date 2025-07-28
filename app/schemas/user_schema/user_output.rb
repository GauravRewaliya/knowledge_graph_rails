
module UserSchema
  class UserOutput
    def self.params
      %i[name email]
    end

    def self.swagger_schema
      {
        type: :object,
        required: %w[name email],
        properties: {
          name: { type: :string, example: 'John' },
          email: { type: :string, example: 'john@example.com' },
        }
      }
    end
  end
end
