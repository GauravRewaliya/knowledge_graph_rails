class CreateUserBookmarks < ActiveRecord::Migration[8.0]
  def change
    create_table :user_bookmarks do |t|
      t.references :user, null: false, foreign_key: true
      t.references :bookmarkable, polymorphic: true, null: false

      t.timestamps
    end
  end
end
