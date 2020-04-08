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

ActiveRecord::Schema.define(version: 20200403175841) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "admins", force: :cascade do |t|
    t.string "username"
    t.string "password_digest"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "cities", force: :cascade do |t|
    t.bigint "state_id"
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["state_id"], name: "index_cities_on_state_id"
  end

  create_table "gifts", force: :cascade do |t|
    t.string "name"
    t.bigint "value"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "item_codes", force: :cascade do |t|
    t.bigint "item_id"
    t.string "uuid"
    t.bigint "user_id"
    t.datetime "scan_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "gift_id"
    t.index ["gift_id"], name: "index_item_codes_on_gift_id"
    t.index ["item_id"], name: "index_item_codes_on_item_id"
    t.index ["user_id"], name: "index_item_codes_on_user_id"
  end

  create_table "items", force: :cascade do |t|
    t.bigint "shop_id"
    t.string "name"
    t.string "brand"
    t.integer "required_credit", default: 0
    t.string "image"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["shop_id"], name: "index_items_on_shop_id"
  end

  create_table "shops", force: :cascade do |t|
    t.bigint "city_id"
    t.bigint "state_id"
    t.string "name"
    t.string "address"
    t.string "phone"
    t.string "image"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["city_id"], name: "index_shops_on_city_id"
    t.index ["state_id"], name: "index_shops_on_state_id"
  end

  create_table "states", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "uploads", force: :cascade do |t|
    t.string "image"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "mobile"
    t.integer "gender", limit: 2
    t.bigint "credit", default: 0
    t.date "dob"
    t.string "nid"
    t.string "activation_code"
    t.bigint "state_id"
    t.bigint "city_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "email"
    t.index ["city_id"], name: "index_users_on_city_id"
    t.index ["state_id"], name: "index_users_on_state_id"
  end

  add_foreign_key "cities", "states"
  add_foreign_key "item_codes", "gifts"
  add_foreign_key "item_codes", "items"
  add_foreign_key "item_codes", "users"
  add_foreign_key "items", "shops"
  add_foreign_key "shops", "cities"
  add_foreign_key "shops", "states"
  add_foreign_key "users", "cities"
  add_foreign_key "users", "states"
end
