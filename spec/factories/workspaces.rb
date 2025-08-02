# == Schema Information
#
# Table name: workspaces
#
#  id         :integer          not null, primary key
#  name       :string
#  user_id    :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_workspaces_on_user_id  (user_id)
#

FactoryBot.define do
  factory :workspace do
    name { "MyString" }
    user { nil }
  end
end
