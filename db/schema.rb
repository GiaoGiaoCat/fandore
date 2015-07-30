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

ActiveRecord::Schema.define(version: 20150729060436) do

  create_table "addresses", force: :cascade do |t|
    t.integer  "post_code",      limit: 4
    t.string   "full_name",      limit: 255
    t.string   "mobile",         limit: 255
    t.string   "phone_section",  limit: 255
    t.integer  "phone_code",     limit: 4
    t.string   "phone_ext",      limit: 255
    t.text     "address_detail", limit: 65535
    t.string   "province",       limit: 255
    t.string   "district",       limit: 255
    t.datetime "created_at",                                   null: false
    t.datetime "updated_at",                                   null: false
    t.string   "city",           limit: 255
    t.integer  "user_id",        limit: 4
    t.boolean  "is_default",                   default: false
  end

  create_table "products", force: :cascade do |t|
    t.string   "name",             limit: 255,   default: "",   null: false
    t.text     "description",      limit: 65535
    t.datetime "available_on"
    t.datetime "deleted_at"
    t.string   "meta_title",       limit: 255
    t.string   "meta_keywords",    limit: 255
    t.text     "meta_description", limit: 65535
    t.string   "spu",              limit: 255,   default: "",   null: false
    t.boolean  "promotionable",                  default: true
    t.datetime "created_at",                                    null: false
    t.datetime "updated_at",                                    null: false
  end

  add_index "products", ["available_on"], name: "products_available_on", using: :btree
  add_index "products", ["deleted_at"], name: "products_deleted_at", using: :btree

  create_table "profiles", force: :cascade do |t|
    t.integer  "user_id",          limit: 4
    t.string   "avatar",           limit: 255
    t.string   "name",             limit: 40
    t.datetime "birthday"
    t.integer  "gender",           limit: 4
    t.string   "partner_name",     limit: 40
    t.datetime "partner_birthday"
    t.string   "partner_email",    limit: 100
    t.string   "partner_mobile",   limit: 50
    t.string   "question",         limit: 255
    t.string   "answer",           limit: 255
  end

  add_index "profiles", ["user_id"], name: "index_profiles_on_user_id", using: :btree

  create_table "properties", force: :cascade do |t|
    t.string   "name",         limit: 255
    t.string   "presentation", limit: 255, null: false
    t.integer  "category",     limit: 4
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  add_index "properties", ["category"], name: "index_properties_on_category", using: :btree

  create_table "properties_prototypes", force: :cascade do |t|
    t.integer "property_id",  limit: 4
    t.integer "prototype_id", limit: 4
  end

  add_index "properties_prototypes", ["property_id"], name: "index_properties_prototypes_on_property_id", using: :btree
  add_index "properties_prototypes", ["prototype_id"], name: "index_properties_prototypes_on_prototype_id", using: :btree

  create_table "prototypes", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",            limit: 100
    t.string   "mobile",           limit: 50
    t.string   "password_digest",  limit: 80
    t.boolean  "is_email_actived",             default: false, null: false
    t.datetime "created_at",                                   null: false
    t.datetime "updated_at",                                   null: false
    t.string   "otp_secret_key",   limit: 255
    t.integer  "otp_counter",      limit: 4
  end

  create_table "verification_codes", force: :cascade do |t|
    t.integer  "user_id",    limit: 4
    t.string   "code",       limit: 24
    t.string   "mobile",     limit: 24
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
  end

  add_index "verification_codes", ["mobile"], name: "index_verification_codes_on_mobile", unique: true, using: :btree
  add_index "verification_codes", ["user_id"], name: "index_verification_codes_on_user_id", using: :btree

  add_foreign_key "profiles", "users"
  add_foreign_key "properties_prototypes", "properties"
  add_foreign_key "properties_prototypes", "prototypes"
end
