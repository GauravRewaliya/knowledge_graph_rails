# == Schema Information
#
# Table name: user_bookmarks
#
#  id                :integer          not null, primary key
#  user_id           :integer          not null
#  bookmarkable_type :string           not null
#  bookmarkable_id   :integer          not null
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#
# Indexes
#
#  index_user_bookmarks_on_bookmarkable  (bookmarkable_type,bookmarkable_id)
#  index_user_bookmarks_on_user_id       (user_id)
#

FactoryBot.define do
  factory :user_bookmark do
    user { nil }
    bookmarkable { nil }
  end
end
