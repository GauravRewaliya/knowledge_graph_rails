class CreateChatSessions < ActiveRecord::Migration[8.0]
  def change
    create_table :chat_sessions do |t|
      t.string :name
      t.text :desc
      t.string :external_id
      t.json :meta_data
      t.datetime :last_used_at
      t.references :chatgpt, null: false, foreign_key: true
      t.references :workspace, null: false, foreign_key: true

      t.timestamps
    end
  end
end
