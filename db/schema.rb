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

ActiveRecord::Schema.define(version: 20150724152706) do

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
  end

  add_index "profiles", ["user_id"], name: "index_profiles_on_user_id", using: :btree

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

  add_index "verification_codes", ["mobile"], name: "index_verification_codes_on_mobile", using: :btree
  add_index "verification_codes", ["user_id"], name: "index_verification_codes_on_user_id", using: :btree

  add_foreign_key "profiles", "users"
end
