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

ActiveRecord::Schema.define(version: 20170916184903) do

  create_table "entries", force: :cascade do |t|
    t.integer "amount"
    t.string "account"
    t.string "description"
    t.boolean "paid"
    t.date "date"
    t.integer "property_id"
    t.integer "entry_category_id"
    t.integer "sheet_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["entry_category_id"], name: "index_entries_on_entry_category_id"
    t.index ["property_id"], name: "index_entries_on_property_id"
    t.index ["sheet_id"], name: "index_entries_on_sheet_id"
  end

  create_table "entry_categories", force: :cascade do |t|
    t.string "name"
    t.boolean "debt"
    t.boolean "operating"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "properties", force: :cascade do |t|
    t.string "address"
    t.string "city"
    t.string "state"
    t.string "zip"
    t.string "status", default: "prospect"
    t.integer "user_id"
    t.text "notes"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_properties_on_user_id"
  end

  create_table "sheets", force: :cascade do |t|
    t.string "title"
    t.integer "year"
    t.boolean "display"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_sheets_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

end
