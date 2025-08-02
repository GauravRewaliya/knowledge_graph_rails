
class BaseSchema < Dry::Validation::Contract

  def self.custom_schema
    type_schema = self.schema.type_schema
    required = []
    properties = {}

    type_schema.keys.each do |data|
      key = data.name.to_s
      data_type = data.type.primitive.name.downcase
      if data_type == 'hash'
        data_type = :object
        ... # TODO
        continue
      end
      properties[key] = {
        type: data_type,
        example: data.meta[:example],
        default: data.meta[:default],
        enum: data.meta[:enum],
        options: data.meta[:options],
        nullable: data.meta[:maybe]
      }.compact
      if data.meta.fetch(:required, false)
        properties[key][:required] = true
        required << key
      end
    end

    {
      type: :object,
      properties: properties,
      required: required
    }
  end
end
# TODO: Required no need to mention // cant able to do ignore