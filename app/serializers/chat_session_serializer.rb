class ChatSessionSerializer < ActiveModel::Serializer
  attributes :id, :name, :desc, :external_id, :meta_data, :last_used_at
  has_one :chatgpt
  has_one :workspace
end
