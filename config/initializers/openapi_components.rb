module OpenApiSchemas
  def self.all
    {
      ScrappingTableCreateRequest: ScrappingTableSchema::CreateRequest.custom_schema
    }
  end
end