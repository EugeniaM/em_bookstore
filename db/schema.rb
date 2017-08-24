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

ActiveRecord::Schema.define(version: 20170822174443) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_admin_comments", force: :cascade do |t|
    t.string "namespace"
    t.text "body"
    t.string "resource_type"
    t.bigint "resource_id"
    t.string "author_type"
    t.bigint "author_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["author_type", "author_id"], name: "index_active_admin_comments_on_author_type_and_author_id"
    t.index ["namespace"], name: "index_active_admin_comments_on_namespace"
    t.index ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource_type_and_resource_id"
  end

  create_table "admin_users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_admin_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_admin_users_on_reset_password_token", unique: true
  end

  create_table "authors", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "billing_addresses", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "address"
    t.string "city"
    t.string "zip"
    t.string "country"
    t.string "phone"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_billing_addresses_on_user_id"
  end

  create_table "book_authors", force: :cascade do |t|
    t.bigint "book_id"
    t.bigint "author_id"
    t.index ["author_id"], name: "index_book_authors_on_author_id"
    t.index ["book_id"], name: "index_book_authors_on_book_id"
  end

  create_table "books", force: :cascade do |t|
    t.string "title"
    t.string "short_description"
    t.string "full_description"
    t.float "price"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "category_id"
    t.bigint "author_id"
    t.string "covers", default: [], array: true
    t.integer "order_counter", default: 0
    t.string "publication_year"
    t.string "dimensions"
    t.string "materials"
    t.string "review_errors", default: [], array: true
    t.index ["author_id"], name: "index_books_on_author_id"
    t.index ["category_id"], name: "index_books_on_category_id"
  end

  create_table "categories", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "guest_order_items", force: :cascade do |t|
    t.bigint "book_id"
    t.bigint "guest_order_id"
    t.float "unit_price"
    t.float "total_price"
    t.integer "quantity"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["book_id"], name: "index_guest_order_items_on_book_id"
    t.index ["guest_order_id"], name: "index_guest_order_items_on_guest_order_id"
  end

  create_table "guest_orders", force: :cascade do |t|
    t.bigint "order_status_id"
    t.float "total"
    t.float "subtotal"
    t.string "session_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "discount", default: 0
    t.index ["order_status_id"], name: "index_guest_orders_on_order_status_id"
  end

  create_table "order_items", force: :cascade do |t|
    t.bigint "book_id"
    t.bigint "order_id"
    t.float "unit_price"
    t.float "total_price"
    t.integer "quantity"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["book_id"], name: "index_order_items_on_book_id"
    t.index ["order_id"], name: "index_order_items_on_order_id"
  end

  create_table "order_statuses", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "orders", force: :cascade do |t|
    t.date "completed_at"
    t.bigint "order_status_id"
    t.float "total"
    t.float "subtotal"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "discount", default: 0
    t.index ["order_status_id"], name: "index_orders_on_order_status_id"
    t.index ["user_id"], name: "index_orders_on_user_id"
  end

  create_table "reviews", force: :cascade do |t|
    t.string "title"
    t.string "text"
    t.integer "score"
    t.string "status", default: "Unprocessed"
    t.boolean "verified", default: false
    t.integer "user_id"
    t.integer "book_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id", "book_id", "created_at"], name: "index_reviews_on_user_id_and_book_id_and_created_at"
  end

  create_table "shipping_addresses", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "address"
    t.string "city"
    t.string "zip"
    t.string "country"
    t.string "phone"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_shipping_addresses_on_user_id"
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
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "first_name"
    t.string "last_name"
    t.boolean "is_admin", default: false
    t.string "provider"
    t.string "uid"
    t.string "avatar"
    t.string "coupon_code", default: "1234567"
    t.boolean "coupon_used", default: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "billing_addresses", "users"
  add_foreign_key "book_authors", "authors"
  add_foreign_key "book_authors", "books"
  add_foreign_key "books", "authors"
  add_foreign_key "books", "categories"
  add_foreign_key "guest_order_items", "books"
  add_foreign_key "guest_order_items", "guest_orders"
  add_foreign_key "guest_orders", "order_statuses"
  add_foreign_key "order_items", "books"
  add_foreign_key "order_items", "orders"
  add_foreign_key "orders", "order_statuses"
  add_foreign_key "orders", "users"
  add_foreign_key "shipping_addresses", "users"
end
