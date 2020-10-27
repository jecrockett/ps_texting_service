# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_10_27_155556) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "message_sends", force: :cascade do |t|
    t.bigint "message_id", null: false
    t.bigint "provider_id", null: false
    t.string "provider_message_id"
    t.string "status"
    t.datetime "status_updated_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["message_id"], name: "index_message_sends_on_message_id"
    t.index ["provider_id"], name: "index_message_sends_on_provider_id"
    t.index ["provider_message_id"], name: "index_message_sends_on_provider_message_id"
  end

  create_table "messages", force: :cascade do |t|
    t.text "content", null: false
    t.string "recipient", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "providers", force: :cascade do |t|
    t.string "name", null: false
    t.string "url", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  add_foreign_key "message_sends", "messages"
  add_foreign_key "message_sends", "providers"
end
