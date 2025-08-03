# == Schema Information
#
# Table name: chat_sessions
#
#  id           :integer          not null, primary key
#  name         :string
#  desc         :text
#  external_id  :string
#  meta_data    :json
#  last_used_at :datetime
#  chatgpt_id   :integer          not null
#  workspace_id :integer          not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
# Indexes
#
#  index_chat_sessions_on_chatgpt_id    (chatgpt_id)
#  index_chat_sessions_on_workspace_id  (workspace_id)
#

require 'rails_helper'

RSpec.describe ChatSession, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
