# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2022_11_06_214931) do

  create_table "applications", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb3", force: :cascade do |t|
    t.string "token"
    t.string "name"
    t.integer "chats_count", default: 0
    t.timestamp "created_at"
    t.timestamp "updated_at"
  end

  create_table "chats", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb3", force: :cascade do |t|
    t.bigint "application_id"
    t.string "name"
    t.integer "chat_number"
    t.integer "messages_count", default: 0
    t.timestamp "created_at"
    t.timestamp "updated_at"
    t.index ["application_id"], name: "index_chats_on_application_id"
  end

  create_table "messages", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb3", force: :cascade do |t|
    t.bigint "chat_id"
    t.string "message"
    t.integer "message_number"
    t.timestamp "created_at"
    t.timestamp "updated_at"
    t.index ["chat_id"], name: "index_messages_on_chat_id"
  end

  add_foreign_key "chats", "applications"
  add_foreign_key "messages", "chats"
end
