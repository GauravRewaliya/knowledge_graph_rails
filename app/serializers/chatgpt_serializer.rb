class ChatgptSerializer < ActiveModel::Serializer
  attributes :id, :name, :desc, :auth_token, :meta_data, :last_used_at
  has_one :workspace
end
