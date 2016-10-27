# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20161018174108) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "hstore"

  create_table "basins", force: :cascade do |t|
    t.integer  "site_id"
    t.string   "name"
    t.float    "depth"
    t.float    "width"
    t.float    "length"
    t.float    "diameter"
    t.float    "volume"
    t.float    "surface_area"
    t.float    "side_slope_ratio"
    t.string   "archive_float"
    t.datetime "archived_at"
    t.integer  "updated_by_id"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  create_table "customers", force: :cascade do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.string   "archive_number"
    t.datetime "archived_at"
  end

  create_table "discussions", force: :cascade do |t|
    t.integer  "user_id"
    t.text     "body"
    t.string   "holder_model"
    t.integer  "holder_id"
    t.integer  "parent_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  add_index "discussions", ["user_id"], name: "index_discussions_on_user_id", using: :btree

  create_table "properties", force: :cascade do |t|
    t.string   "name"
    t.text     "description"
    t.string   "holder_model"
    t.integer  "created_by_id"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.string   "archive_number"
    t.datetime "archived_at"
  end

  create_table "property_values", force: :cascade do |t|
    t.integer  "property_id"
    t.string   "data"
    t.datetime "archived_at"
    t.integer  "archived_by_id"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.integer  "holder_id"
    t.integer  "creator_id"
    t.string   "archive_number"
  end

  create_table "sites", force: :cascade do |t|
    t.integer  "customer_id"
    t.string   "address1"
    t.string   "address2"
    t.string   "city"
    t.string   "state"
    t.string   "zip"
    t.string   "phone"
    t.string   "gps"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.string   "archive_number"
    t.datetime "archived_at"
    t.string   "name"
    t.integer  "updated_by_id"
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.integer  "role"
    t.string   "first_name"
    t.integer  "customer_id"
    t.string   "last_name"
    t.string   "phone"
    t.string   "timezone"
    t.text     "comments"
    t.string   "archive_number"
    t.datetime "archived_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
