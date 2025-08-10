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

require 'rails_helper'

RSpec.describe GraphQueryfier, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
