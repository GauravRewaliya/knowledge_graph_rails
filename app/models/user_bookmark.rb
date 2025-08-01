# == Schema Information
#
# Table name: user_bookmarks
#
#  id                   :integer
#  user_id              :integer
#  bookmarkable_type    :string
#  bookmarkable_id      :integer
#  created_at           :datetime
#  updated_at           :datetime
#

# Table name: user_bookmarks
#
#  id                   :integer
#  user_id              :integer
#  bookmarkable_type    :string
#  bookmarkable_id      :integer
#  created_at           :datetime
#  updated_at           :datetime
#

# Table name: user_bookmarks
#
#  id                   :integer
#  user_id              :integer
#  bookmarkable_type    :string
#  bookmarkable_id      :integer
#  created_at           :datetime
#  updated_at           :datetime
#

# Table name: user_bookmarks
#
#  id                   :integer
#  user_id              :integer
#  bookmarkable_type    :string
#  bookmarkable_id      :integer
#  created_at           :datetime
#  updated_at           :datetime
#

# Table name: user_bookmarks
#
#  id                   :integer
#  user_id              :integer
#  bookmarkable_type    :string
#  bookmarkable_id      :integer
#  created_at           :datetime
#  updated_at           :datetime
#

class UserBookmark < ApplicationRecord
  belongs_to :user
  belongs_to :bookmarkable, polymorphic: true
end
