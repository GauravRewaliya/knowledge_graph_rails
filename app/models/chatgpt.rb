# == Schema Information
#
# Table name: chatgpts
#
#  id           :integer          not null, primary key
#  name         :string
#  desc         :text
#  auth_token   :string
#  meta_data    :json
#  last_used_at :datetime
#  workspace_id :integer          not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
# Indexes
#
#  index_chatgpts_on_workspace_id  (workspace_id)
#

class Chatgpt < ApplicationRecord
  belongs_to :workspace
end
