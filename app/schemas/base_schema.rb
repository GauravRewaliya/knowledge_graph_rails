
class BaseSchema < Dry::Validation::Contract

  def self.custom_schema
    type_schema = self.schema.type_schema

    type_schema.keys.map{ |data|
      self._options_parser(data)
    }
  end

  private
  def self._sub_option_parser(record_data)
    data_type = record_data.type.primitive.name.downcase
    if data_type == 'hash'
      # condition when hash as no sub-options # TODO: check
      return self._options_parser(record_data) # TODO: check
    else
      response_data = self._filter_properties(record_data)
      response_data[:required] = true if record_data.meta.fetch(:required, false)
      return response_data
    end
  end

  def self._options_parser(option_data)
    required = []
    properties = {}
    option_data.each do |data|
      record_data = self._sub_option_parser(data)
      required << data.name if record_data[:required]
    end
    {
      type: :object,
      properties: properties,
      required: required
    }
  end

  def self._filter_properties(data)
    {
      type: data_type,
      example: data.meta[:example],
      default: data.meta[:default],
      enum: data.meta[:enum],
      options: data.meta[:options],
      nullable: data.meta[:maybe]
    }.compact
  end
end
# TODO: Required no need to mention // cant able to do ignore