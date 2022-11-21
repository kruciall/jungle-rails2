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

ActiveRecord::Schema.define(version: 2022_11_18_233123) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "categories", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "favorites", id: :serial, force: :cascade do |t|
    t.integer "user_id"
    t.integer "map_id"
  end

  create_table "line_items", force: :cascade do |t|
    t.bigint "order_id"
    t.bigint "product_id"
    t.integer "quantity"
    t.integer "item_price_cents"
    t.integer "total_price_cents"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["order_id"], name: "index_line_items_on_order_id"
    t.index ["product_id"], name: "index_line_items_on_product_id"
  end

  create_table "maps", id: :serial, force: :cascade do |t|
    t.string "name", limit: 255, null: false
    t.integer "user_id"
    t.float "latitude"
    t.float "longitude"
    t.string "img_url", limit: 255
  end

  create_table "orders", force: :cascade do |t|
    t.integer "total_cents"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "stripe_charge_id"
    t.string "email"
  end

  create_table "points", id: :serial, force: :cascade do |t|
    t.string "title", limit: 255, null: false
    t.string "image", limit: 255, null: false
    t.text "description"
    t.integer "map_id"
    t.float "latitude", null: false
    t.float "longitude", null: false
  end

  create_table "products", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.string "image"
    t.integer "price_cents"
    t.integer "quantity"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "category_id"
    t.index ["category_id"], name: "index_products_on_category_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "password_digest"
    t.string "email"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  add_foreign_key "favorites", "maps", name: "favorites_map_id_fkey"
  add_foreign_key "line_items", "orders"
  add_foreign_key "line_items", "products"
  add_foreign_key "points", "maps", name: "points_map_id_fkey"
  add_foreign_key "products", "categories"
end
