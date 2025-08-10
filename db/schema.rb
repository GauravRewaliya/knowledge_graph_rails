# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[8.0].define(version: 2025_08_10_094852) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "chat_sessions", force: :cascade do |t|
    t.string "name"
    t.text "desc"
    t.string "external_id"
    t.json "meta_data"
    t.datetime "last_used_at"
    t.bigint "chatgpt_id", null: false
    t.bigint "workspace_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["chatgpt_id"], name: "index_chat_sessions_on_chatgpt_id"
    t.index ["workspace_id"], name: "index_chat_sessions_on_workspace_id"
  end

  create_table "chatgpts", force: :cascade do |t|
    t.string "name"
    t.text "desc"
    t.string "auth_token"
    t.json "meta_data"
    t.datetime "last_used_at"
    t.bigint "workspace_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["workspace_id"], name: "index_chatgpts_on_workspace_id"
  end

  create_table "graph_queryfiers", force: :cascade do |t|
    t.string "entity_type"
    t.string "desc"
    t.string "cypher_dynamic_query"
    t.json "meta_data_swagger_docs"
    t.bigint "workspace_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["workspace_id"], name: "index_graph_queryfiers_on_workspace_id"
  end

  create_table "scrapping_tables", force: :cascade do |t|
    t.string "source_type_key"
    t.string "url"
    t.jsonb "request"
    t.jsonb "response"
    t.jsonb "filterer_json"
    t.text "conveter_code"
    t.jsonb "final_clean_response"
    t.integer "processing_status"
    t.bigint "workspace_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["workspace_id"], name: "index_scrapping_tables_on_workspace_id"
  end

  create_table "user_bookmarks", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "bookmarkable_type", null: false
    t.bigint "bookmarkable_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["bookmarkable_type", "bookmarkable_id"], name: "index_user_bookmarks_on_bookmarkable"
    t.index ["user_id"], name: "index_user_bookmarks_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "password_digest"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "workspaces", force: :cascade do |t|
    t.string "name"
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_workspaces_on_user_id"
  end

  add_foreign_key "chat_sessions", "chatgpts"
  add_foreign_key "chat_sessions", "workspaces"
  add_foreign_key "chatgpts", "workspaces"
  add_foreign_key "graph_queryfiers", "workspaces"
  add_foreign_key "scrapping_tables", "workspaces"
  add_foreign_key "user_bookmarks", "users"
  add_foreign_key "workspaces", "users"
end
