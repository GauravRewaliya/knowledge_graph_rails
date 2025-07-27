class UserBookmark < ApplicationRecord
  belongs_to :user
  belongs_to :bookmarkable, polymorphic: true
end
