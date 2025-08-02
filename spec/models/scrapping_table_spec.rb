# == Schema Information
#
# Table name: scrapping_tables
#
#  id                   :integer          not null, primary key
#  source_type_key      :string
#  url                  :string
#  request              :jsonb
#  response             :jsonb
#  filterer_json        :jsonb
#  conveter_code        :text
#  final_clean_response :jsonb
#  processing_status    :integer
#  workspace_id         :integer          not null
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#
# Indexes
#
#  index_scrapping_tables_on_workspace_id  (workspace_id)
#

require 'rails_helper'

RSpec.describe ScrappingTable, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
