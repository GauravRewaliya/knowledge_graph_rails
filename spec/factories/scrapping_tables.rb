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

FactoryBot.define do
  factory :scrapping_table do
    source_type_key { "MyString" }
    url { "MyString" }
    request { "" }
    response { "" }
    filterer_json { "" }
    conveter_code { "MyText" }
    final_clean_response { "" }
    processing_status { "MyString" }
    workspace { nil }
  end
end
