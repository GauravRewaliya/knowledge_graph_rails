class CreateChatgpts < ActiveRecord::Migration[8.0]
  def change
    create_table :chatgpts do |t|
      t.string :name
      t.text :desc
      t.string :auth_token
      t.json :meta_data
      t.datetime :last_used_at
      t.references :workspace, null: false, foreign_key: true

      t.timestamps
    end
  end
end
