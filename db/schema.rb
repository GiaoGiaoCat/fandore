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

ActiveRecord::Schema.define(version: 20150808102132) do

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

  create_table "favorites", force: :cascade do |t|
    t.string   "note",         limit: 50,  default: ""
    t.integer  "favable_id",   limit: 4
    t.string   "favable_type", limit: 191
    t.integer  "user_id",      limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "favorites", ["favable_id"], name: "index_favorites_on_favable_id", using: :btree
  add_index "favorites", ["favable_type"], name: "index_favorites_on_favable_type", using: :btree
  add_index "favorites", ["user_id"], name: "index_favorites_on_user_id", using: :btree

  create_table "line_items", force: :cascade do |t|
    t.integer  "order_id",             limit: 4
    t.decimal  "price",                          precision: 10, scale: 2, default: 0.0, null: false
    t.decimal  "adjustment_total",               precision: 10, scale: 2, default: 0.0, null: false
    t.decimal  "additional_tax_total",           precision: 10, scale: 2, default: 0.0, null: false
    t.decimal  "promo_total",                    precision: 10, scale: 2, default: 0.0, null: false
    t.datetime "created_at",                                                            null: false
    t.datetime "updated_at",                                                            null: false
  end

  create_table "option_types", force: :cascade do |t|
    t.string   "name",         limit: 255
    t.string   "presentation", limit: 255
    t.integer  "position",     limit: 4,   default: 0, null: false
    t.datetime "created_at",                           null: false
    t.datetime "updated_at",                           null: false
  end

  add_index "option_types", ["position"], name: "index_option_types_on_position", using: :btree

  create_table "option_types_prototypes", id: false, force: :cascade do |t|
    t.integer "prototype_id",   limit: 4
    t.integer "option_type_id", limit: 4
  end

  add_index "option_types_prototypes", ["option_type_id"], name: "index_option_types_prototypes_on_option_type_id", using: :btree
  add_index "option_types_prototypes", ["prototype_id"], name: "index_option_types_prototypes_on_prototype_id", using: :btree

  create_table "option_values", force: :cascade do |t|
    t.string   "name",           limit: 255
    t.integer  "position",       limit: 4
    t.string   "presentation",   limit: 255
    t.integer  "option_type_id", limit: 4
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
  end

  add_index "option_values", ["option_type_id"], name: "index_option_values_on_option_type_id", using: :btree
  add_index "option_values", ["position"], name: "index_option_values_on_position", using: :btree

  create_table "option_values_variants", id: false, force: :cascade do |t|
    t.integer "variant_id",      limit: 4
    t.integer "option_value_id", limit: 4
  end

  add_index "option_values_variants", ["variant_id", "option_value_id"], name: "index_option_values_variants_on_variant_id_and_option_value_id", using: :btree
  add_index "option_values_variants", ["variant_id"], name: "index_option_values_variants_on_variant_id", using: :btree

  create_table "orders", force: :cascade do |t|
    t.string   "number",                 limit: 191
    t.decimal  "item_total",                           precision: 10
    t.decimal  "total",                                precision: 10
    t.string   "state",                  limit: 191
    t.decimal  "adjustment_total",                     precision: 10
    t.integer  "user_id",                limit: 4
    t.integer  "ship_address_id",        limit: 4
    t.decimal  "payment_total",                        precision: 10
    t.integer  "shipping_method_id",     limit: 4
    t.string   "shipment_state",         limit: 191
    t.string   "payment_state",          limit: 191
    t.string   "email",                  limit: 191
    t.text     "special_instructions",   limit: 65535
    t.string   "currency",               limit: 191
    t.string   "last_ip_address",        limit: 191
    t.integer  "created_by_id",          limit: 4
    t.decimal  "shipment_total",                       precision: 10
    t.decimal  "promo_total",                          precision: 10
    t.string   "channel",                limit: 191
    t.integer  "item_count",             limit: 4
    t.integer  "approver_id",            limit: 4
    t.datetime "approved_at"
    t.boolean  "confirmation_delivered"
    t.boolean  "considered_risky"
    t.integer  "state_lock_version",     limit: 4
    t.datetime "created_at",                                          null: false
    t.datetime "updated_at",                                          null: false
  end

  create_table "product_option_types", force: :cascade do |t|
    t.integer  "position",       limit: 4, default: 0
    t.integer  "option_type_id", limit: 4
    t.integer  "product_id",     limit: 4
    t.datetime "created_at",                           null: false
    t.datetime "updated_at",                           null: false
  end

  add_index "product_option_types", ["option_type_id"], name: "index_product_option_types_on_option_type_id", using: :btree
  add_index "product_option_types", ["position"], name: "index_product_option_types_on_position", using: :btree
  add_index "product_option_types", ["product_id"], name: "index_product_option_types_on_product_id", using: :btree

  create_table "product_properties", force: :cascade do |t|
    t.string   "value",       limit: 191
    t.integer  "product_id",  limit: 4
    t.integer  "property_id", limit: 4
    t.integer  "position",    limit: 4,   default: 0
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
  end

  add_index "product_properties", ["position"], name: "index_product_properties_on_position", using: :btree
  add_index "product_properties", ["product_id"], name: "index_product_properties_on_product_id", using: :btree
  add_index "product_properties", ["property_id"], name: "index_product_properties_on_property_id", using: :btree

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

  create_table "products_taxons", force: :cascade do |t|
    t.integer  "taxon_id",   limit: 4
    t.integer  "product_id", limit: 4
    t.integer  "position",   limit: 4, default: 0
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
  end

  add_index "products_taxons", ["position"], name: "index_products_taxons_on_position", using: :btree
  add_index "products_taxons", ["product_id"], name: "index_products_taxons_on_product_id", using: :btree
  add_index "products_taxons", ["taxon_id"], name: "index_products_taxons_on_taxon_id", using: :btree

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

  create_table "promotion_actions", force: :cascade do |t|
    t.integer  "promotion_id", limit: 4
    t.string   "type_name",    limit: 191
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.text     "preferences",  limit: 65535
  end

  create_table "promotion_categories", force: :cascade do |t|
    t.string   "name",       limit: 191
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "promotion_rules", force: :cascade do |t|
    t.integer  "promotion_id", limit: 4
    t.string   "type_name",    limit: 191
    t.text     "preferences",  limit: 65535
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
  end

  create_table "promotions", force: :cascade do |t|
    t.string   "description",           limit: 191
    t.datetime "expires_at"
    t.datetime "starts_at"
    t.string   "name",                  limit: 191
    t.string   "type_name",             limit: 191
    t.integer  "usage_limit",           limit: 4
    t.integer  "promotion_category_id", limit: 4
    t.string   "code",                  limit: 191
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
  end

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

  create_table "recommendations", force: :cascade do |t|
    t.integer  "product_id",           limit: 4
    t.integer  "recommend_product_id", limit: 4
    t.integer  "position",             limit: 4
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
  end

  add_index "recommendations", ["position"], name: "index_recommendations_on_position", using: :btree

  create_table "taxonomies", force: :cascade do |t|
    t.string   "name",       limit: 191, null: false
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "taxons", force: :cascade do |t|
    t.integer  "taxonomy_id", limit: 4
    t.string   "name",        limit: 191, null: false
    t.string   "ancestry",    limit: 191
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  add_index "taxons", ["ancestry"], name: "index_taxons_on_ancestry", using: :btree

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

  create_table "variants", force: :cascade do |t|
    t.string   "sku",        limit: 191,                          default: "",    null: false
    t.datetime "deleted_at"
    t.boolean  "is_master",                                       default: false
    t.decimal  "cost_price",             precision: 10, scale: 2
    t.integer  "position",   limit: 4
    t.integer  "product_id", limit: 4
    t.datetime "created_at",                                                      null: false
    t.datetime "updated_at",                                                      null: false
  end

  add_index "variants", ["deleted_at"], name: "index_variants_on_deleted_at", using: :btree
  add_index "variants", ["is_master"], name: "index_variants_on_is_master", using: :btree
  add_index "variants", ["position"], name: "index_variants_on_position", using: :btree
  add_index "variants", ["product_id"], name: "index_variants_on_product_id", using: :btree
  add_index "variants", ["sku"], name: "index_variants_on_sku", using: :btree

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
