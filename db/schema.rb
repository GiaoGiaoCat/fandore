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

ActiveRecord::Schema.define(version: 20150808150844) do

  create_table "addresses", force: :cascade do |t|
    t.integer  "user_id",         limit: 4
    t.string   "name",            limit: 191
    t.string   "zipcode",         limit: 191
    t.string   "mobile",          limit: 191
    t.string   "province",        limit: 191
    t.string   "district",        limit: 191
    t.string   "city",            limit: 191
    t.string   "address",         limit: 191
    t.string   "phone_area_code", limit: 191
    t.string   "phone",           limit: 191
    t.string   "phone_ext_code",  limit: 191
    t.boolean  "is_default",                  default: false
    t.datetime "created_at",                                  null: false
    t.datetime "updated_at",                                  null: false
  end

  add_index "addresses", ["user_id"], name: "index_addresses_on_user_id", using: :btree

  create_table "carts", force: :cascade do |t|
    t.integer "user_id", limit: 4
  end

  add_index "carts", ["user_id"], name: "index_carts_on_user_id", using: :btree

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
    t.integer  "order_id",         limit: 4
    t.integer  "cart_id",          limit: 4
    t.integer  "variant_id",       limit: 4
    t.integer  "quantity",         limit: 4,                                        null: false
    t.decimal  "price",                      precision: 10, scale: 2,               null: false
    t.decimal  "adjustment_total",           precision: 10, scale: 2, default: 0.0
    t.decimal  "promo_total",                precision: 10, scale: 2, default: 0.0
    t.datetime "created_at",                                                        null: false
    t.datetime "updated_at",                                                        null: false
  end

  add_index "line_items", ["cart_id"], name: "index_line_items_on_cart_id", using: :btree
  add_index "line_items", ["order_id"], name: "index_line_items_on_order_id", using: :btree
  add_index "line_items", ["variant_id"], name: "index_line_items_on_variant_id", using: :btree

  create_table "option_types", force: :cascade do |t|
    t.string   "name",         limit: 191
    t.string   "presentation", limit: 191
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
    t.string   "name",           limit: 191
    t.integer  "position",       limit: 4
    t.string   "presentation",   limit: 191
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
    t.string   "number",                 limit: 32
    t.string   "email",                  limit: 191
    t.integer  "user_id",                limit: 4
    t.text     "special_instructions",   limit: 65535
    t.integer  "shipping_address_id",    limit: 4
    t.integer  "billing_address_id",     limit: 4
    t.integer  "item_count",             limit: 4,                              default: 0
    t.string   "guest_token",            limit: 191
    t.integer  "state",                  limit: 4
    t.decimal  "item_total",                           precision: 10, scale: 2, default: 0.0,   null: false
    t.decimal  "total",                                precision: 10, scale: 2, default: 0.0,   null: false
    t.decimal  "adjustment_total",                     precision: 10, scale: 2, default: 0.0,   null: false
    t.decimal  "payment_total",                        precision: 10, scale: 2, default: 0.0
    t.decimal  "promo_total",                          precision: 10, scale: 2, default: 0.0
    t.decimal  "shipment_total",                       precision: 10, scale: 2, default: 0.0,   null: false
    t.integer  "created_by_id",          limit: 4
    t.string   "last_ip_address",        limit: 191
    t.datetime "completed_at"
    t.integer  "approver_id",            limit: 4
    t.datetime "approved_at"
    t.integer  "canceler_id",            limit: 4
    t.datetime "canceled_at"
    t.boolean  "confirmation_delivered",                                        default: false
    t.datetime "created_at",                                                                    null: false
    t.datetime "updated_at",                                                                    null: false
  end

  add_index "orders", ["approver_id"], name: "index_orders_on_approver_id", using: :btree
  add_index "orders", ["billing_address_id"], name: "index_orders_on_billing_address_id", using: :btree
  add_index "orders", ["completed_at"], name: "index_orders_on_completed_at", using: :btree
  add_index "orders", ["confirmation_delivered"], name: "index_orders_on_confirmation_delivered", using: :btree
  add_index "orders", ["created_by_id"], name: "index_orders_on_created_by_id", using: :btree
  add_index "orders", ["guest_token"], name: "index_orders_on_guest_token", using: :btree
  add_index "orders", ["number"], name: "index_orders_on_number", using: :btree
  add_index "orders", ["shipping_address_id"], name: "index_orders_on_shipping_address_id", using: :btree
  add_index "orders", ["user_id", "created_by_id"], name: "index_orders_on_user_id_and_created_by_id", using: :btree
  add_index "orders", ["user_id"], name: "index_orders_on_user_id", using: :btree

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
    t.string   "name",             limit: 191,   default: "",   null: false
    t.text     "description",      limit: 65535
    t.datetime "available_on"
    t.datetime "deleted_at"
    t.string   "meta_title",       limit: 191
    t.string   "meta_keywords",    limit: 191
    t.text     "meta_description", limit: 65535
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
    t.string   "avatar",           limit: 191
    t.string   "name",             limit: 40
    t.datetime "birthday"
    t.integer  "gender",           limit: 4
    t.string   "partner_name",     limit: 40
    t.datetime "partner_birthday"
    t.string   "partner_email",    limit: 100
    t.string   "partner_mobile",   limit: 50
    t.string   "question",         limit: 191
    t.string   "answer",           limit: 191
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
  end

  add_index "profiles", ["user_id"], name: "index_profiles_on_user_id", using: :btree

  create_table "promotion_actions", force: :cascade do |t|
    t.integer  "promotion_id", limit: 4
    t.string   "type_name",    limit: 191
    t.text     "preferences",  limit: 65535
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
  end

  add_index "promotion_actions", ["promotion_id"], name: "index_promotion_actions_on_promotion_id", using: :btree

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

  add_index "promotion_rules", ["promotion_id"], name: "index_promotion_rules_on_promotion_id", using: :btree

  create_table "promotions", force: :cascade do |t|
    t.string   "description",           limit: 191
    t.datetime "expires_at"
    t.datetime "starts_at"
    t.string   "name",                  limit: 191
    t.integer  "usage_limit",           limit: 4,   default: 0
    t.integer  "promotion_category_id", limit: 4
    t.string   "code",                  limit: 191
    t.datetime "created_at",                                    null: false
    t.datetime "updated_at",                                    null: false
  end

  create_table "properties", force: :cascade do |t|
    t.string   "name",         limit: 191
    t.string   "presentation", limit: 191, null: false
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  create_table "properties_prototypes", id: false, force: :cascade do |t|
    t.integer "property_id",  limit: 4
    t.integer "prototype_id", limit: 4
  end

  add_index "properties_prototypes", ["property_id"], name: "index_properties_prototypes_on_property_id", using: :btree
  add_index "properties_prototypes", ["prototype_id"], name: "index_properties_prototypes_on_prototype_id", using: :btree

  create_table "prototypes", force: :cascade do |t|
    t.string   "name",       limit: 191
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
  add_index "taxons", ["taxonomy_id"], name: "index_taxons_on_taxonomy_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "email",              limit: 100
    t.string   "mobile",             limit: 50
    t.string   "password_digest",    limit: 80
    t.string   "otp_secret_key",     limit: 191
    t.integer  "otp_counter",        limit: 4
    t.integer  "sign_in_count",      limit: 4,   default: 0, null: false
    t.datetime "activated_at"
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip", limit: 191
    t.string   "last_sign_in_ip",    limit: 191
    t.integer  "role",               limit: 4,   default: 1
    t.datetime "created_at",                                 null: false
    t.datetime "updated_at",                                 null: false
  end

  create_table "variants", force: :cascade do |t|
    t.string   "sku",           limit: 191,                          default: "",    null: false
    t.datetime "deleted_at"
    t.boolean  "is_master",                                          default: false
    t.decimal  "price",                     precision: 10, scale: 2
    t.decimal  "display_price",             precision: 10, scale: 2
    t.decimal  "cost_price",                precision: 8,  scale: 2
    t.integer  "position",      limit: 4
    t.integer  "status",        limit: 4,                            default: 0
    t.integer  "product_id",    limit: 4
    t.decimal  "weight",                    precision: 8,  scale: 2
    t.decimal  "height",                    precision: 8,  scale: 2
    t.decimal  "width",                     precision: 8,  scale: 2
    t.decimal  "depth",                     precision: 8,  scale: 2
    t.string   "cost_currency", limit: 191
    t.datetime "created_at",                                                         null: false
    t.datetime "updated_at",                                                         null: false
  end

  add_index "variants", ["deleted_at"], name: "index_variants_on_deleted_at", using: :btree
  add_index "variants", ["is_master"], name: "index_variants_on_is_master", using: :btree
  add_index "variants", ["position"], name: "index_variants_on_position", using: :btree
  add_index "variants", ["product_id"], name: "index_variants_on_product_id", using: :btree
  add_index "variants", ["sku"], name: "index_variants_on_sku", using: :btree

  create_table "verification_codes", force: :cascade do |t|
    t.integer  "user_id",    limit: 4
    t.string   "code",       limit: 191
    t.string   "to",         limit: 100
    t.string   "type",       limit: 100
    t.string   "last_ip",    limit: 191
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_index "verification_codes", ["to"], name: "index_verification_codes_on_to", using: :btree
  add_index "verification_codes", ["type"], name: "index_verification_codes_on_type", using: :btree
  add_index "verification_codes", ["user_id"], name: "index_verification_codes_on_user_id", using: :btree

  add_foreign_key "addresses", "users"
  add_foreign_key "profiles", "users"
  add_foreign_key "properties_prototypes", "properties"
  add_foreign_key "properties_prototypes", "prototypes"
end
