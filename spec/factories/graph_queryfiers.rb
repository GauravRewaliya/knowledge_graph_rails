# == Schema Information
#
# Table name: graph_queryfiers
#
#  id                     :integer          not null, primary key
#  entity_type            :string
#  desc                   :string
#  cypher_dynamic_query   :string
#  meta_data_swagger_docs :json
#  workspace_id           :integer          not null
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
# Indexes
#
#  index_graph_queryfiers_on_workspace_id  (workspace_id)
#

FactoryBot.define do
  factory :graph_queryfier do
    entity_type { "MyString" }
    desc { "MyString" }
    cypher_dynamic_query { "MyString" }
    meta_data_swagger_docs { "" }
    workspace { nil }
  end
end
