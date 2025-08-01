# == Schema Information
#
# Table name: scrapping_tables
#
#  id                   :integer
#  source_type_key      :string
#  url                  :string
#  request              :jsonb
#  response             :jsonb
#  filterer_json        :jsonb
#  conveter_code        :text
#  final_clean_response :jsonb
#  processing_status    :integer
#  workspace_id         :integer
#  created_at           :datetime
#  updated_at           :datetime
#

class ScrappingTable < ApplicationRecord
  belongs_to :workspace

  enum :processing_status, {
    unprocessed: 0,
    sp_filterer: 1,
    filtered: 2,
    sp_conveter: 3,
    conveter: 4,
    sp_convert: 5,
    final_response: 6
  }

  def request_struct
    ScrapperRequestBase.from_hash(request || {})
  end

  def request_struct=(obj)
    self.request = obj.as_json
  end
  # validates :url, :source_type_key, :workspace_id, presence: true
end
