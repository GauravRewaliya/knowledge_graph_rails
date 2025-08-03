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

FactoryBot.define do
  factory :chatgpt do
    name { "MyString" }
    desc { "MyText" }
    auth_token { "MyString" }
    meta_data { "" }
    last_used_at { "2025-08-03 11:58:22" }
    workspace { nil }
  end
end
