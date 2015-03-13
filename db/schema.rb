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

ActiveRecord::Schema.define(version: 20150313055751) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "accountinfos", force: true do |t|
    t.integer  "brand_id"
    t.string   "centername"
    t.string   "personname"
    t.string   "email"
    t.string   "mobile"
    t.string   "landline"
    t.string   "area"
    t.text     "address_1"
    t.text     "address_2"
    t.string   "landmark"
    t.string   "city"
    t.integer  "pin"
    t.string   "pan"
    t.string   "tan"
    t.string   "tin"
    t.string   "taxregno"
    t.string   "acno"
    t.string   "bank_name"
    t.string   "ifsc_code"
    t.text     "bank_address"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "bank_city"
    t.integer  "center_id"
  end

  add_index "accountinfos", ["brand_id"], name: "index_accountinfos_on_brand_id", using: :btree
  add_index "accountinfos", ["center_id"], name: "index_accountinfos_on_center_id", using: :btree

  create_table "average_caches", force: true do |t|
    t.integer  "rater_id"
    t.integer  "rateable_id"
    t.string   "rateable_type"
    t.float    "avg",           null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "average_caches", ["rateable_id", "rateable_type"], name: "index_average_caches_on_rateable_id_and_rateable_type", using: :btree
  add_index "average_caches", ["rater_id"], name: "index_average_caches_on_rater_id", using: :btree

  create_table "bookings", force: true do |t|
    t.integer  "service_id"
    t.integer  "customer_id"
    t.integer  "quantity"
    t.float    "price"
    t.string   "status"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "token"
  end

  create_table "brands", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "categories", force: true do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "categories_centerinfos", id: false, force: true do |t|
    t.integer "centerinfo_id"
    t.integer "category_id"
  end

  add_index "categories_centerinfos", ["category_id"], name: "index_categories_centerinfos_on_category_id", using: :btree
  add_index "categories_centerinfos", ["centerinfo_id"], name: "index_categories_centerinfos_on_centerinfo_id", using: :btree

  create_table "categories_centers", id: false, force: true do |t|
    t.integer "center_id"
    t.integer "category_id"
  end

  add_index "categories_centers", ["category_id"], name: "index_categories_centers_on_category_id", using: :btree
  add_index "categories_centers", ["center_id"], name: "index_categories_centers_on_center_id", using: :btree

  create_table "centerinfos", force: true do |t|
    t.string   "name"
    t.string   "website"
    t.string   "image_id"
    t.integer  "center_photo_gid"
    t.boolean  "fp_verified"
    t.integer  "hour_id"
    t.integer  "slots"
    t.text     "brief_desc"
    t.text     "detailed_desc"
    t.string   "latitude"
    t.string   "longitude"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "centertype_id"
    t.integer  "center_id"
  end

  add_index "centerinfos", ["center_id"], name: "index_centerinfos_on_center_id", using: :btree
  add_index "centerinfos", ["centertype_id"], name: "index_centerinfos_on_centertype_id", using: :btree
  add_index "centerinfos", ["hour_id"], name: "index_centerinfos_on_hour_id", using: :btree

  create_table "centerinfos_experiences", id: false, force: true do |t|
    t.integer "centerinfo_id"
    t.integer "experience_id"
  end

  add_index "centerinfos_experiences", ["centerinfo_id"], name: "index_centerinfos_experiences_on_centerinfo_id", using: :btree
  add_index "centerinfos_experiences", ["experience_id"], name: "index_centerinfos_experiences_on_experience_id", using: :btree

  create_table "centers", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
    t.integer  "partner_id"
  end

  add_index "centers", ["partner_id"], name: "index_centers_on_partner_id", using: :btree

  create_table "centertypes", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "cphotos", force: true do |t|
    t.string   "image_id"
    t.integer  "centerinfo_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "customers", force: true do |t|
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "experiences", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "hours", force: true do |t|
    t.string   "sun_from"
    t.string   "mon_from"
    t.string   "tue_from"
    t.string   "wed_from"
    t.string   "thu_from"
    t.string   "fri_from"
    t.string   "sat_from"
    t.string   "sun_to"
    t.string   "mon_to"
    t.string   "tue_to"
    t.string   "wed_to"
    t.string   "thu_to"
    t.string   "fri_to"
    t.string   "sat_to"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "instructors", force: true do |t|
    t.string   "photo_id"
    t.integer  "center_id"
    t.string   "name"
    t.string   "gender"
    t.string   "mobile"
    t.string   "email"
    t.string   "expertise"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "instructors", ["center_id"], name: "index_instructors_on_center_id", using: :btree

  create_table "nifty_attachments", force: true do |t|
    t.integer  "parent_id"
    t.string   "parent_type"
    t.string   "token"
    t.string   "digest"
    t.string   "role"
    t.string   "file_name"
    t.string   "file_type"
    t.binary   "data"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "overall_averages", force: true do |t|
    t.integer  "rateable_id"
    t.string   "rateable_type"
    t.float    "overall_avg",   null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "overall_averages", ["rateable_id", "rateable_type"], name: "index_overall_averages_on_rateable_id_and_rateable_type", using: :btree

  create_table "partners", force: true do |t|
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "business_name"
    t.integer  "category_id"
  end

  create_table "rates", force: true do |t|
    t.integer  "rater_id"
    t.integer  "rateable_id"
    t.string   "rateable_type"
    t.float    "stars",         null: false
    t.string   "dimension"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "rates", ["rateable_id", "rateable_type"], name: "index_rates_on_rateable_id_and_rateable_type", using: :btree
  add_index "rates", ["rater_id"], name: "index_rates_on_rater_id", using: :btree

  create_table "rating_caches", force: true do |t|
    t.integer  "cacheable_id"
    t.string   "cacheable_type"
    t.float    "avg",            null: false
    t.integer  "qty",            null: false
    t.string   "dimension"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "rating_caches", ["cacheable_id", "cacheable_type"], name: "index_rating_caches_on_cacheable_id_and_cacheable_type", using: :btree

  create_table "ratings", force: true do |t|
    t.integer  "customer_id"
    t.integer  "service_id"
    t.float    "rate"
    t.text     "comment"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "services", force: true do |t|
    t.integer  "center_id"
    t.integer  "category_id"
    t.string   "service_type"
    t.string   "name"
    t.datetime "validity"
    t.string   "time_taken"
    t.float    "original_price"
    t.float    "selling_price"
    t.integer  "gender_id"
    t.string   "schedule"
    t.datetime "expired_on"
    t.datetime "start_date"
    t.datetime "end_date"
    t.integer  "seats"
    t.boolean  "active"
    t.text     "service_desc"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "days"
  end

  add_index "services", ["category_id"], name: "index_services_on_category_id", using: :btree
  add_index "services", ["center_id"], name: "index_services_on_center_id", using: :btree

  create_table "superadmins", force: true do |t|
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "taggings", force: true do |t|
    t.integer  "tag_id"
    t.integer  "taggable_id"
    t.string   "taggable_type"
    t.integer  "tagger_id"
    t.string   "tagger_type"
    t.string   "context",       limit: 128
    t.datetime "created_at"
  end

  add_index "taggings", ["tag_id", "taggable_id", "taggable_type", "context", "tagger_id", "tagger_type"], name: "taggings_idx", unique: true, using: :btree
  add_index "taggings", ["taggable_id", "taggable_type", "context"], name: "index_taggings_on_taggable_id_and_taggable_type_and_context", using: :btree

  create_table "tags", force: true do |t|
    t.string  "name"
    t.integer "taggings_count", default: 0
  end

  add_index "tags", ["name"], name: "index_tags_on_name", unique: true, using: :btree

  create_table "users", force: true do |t|
    t.string   "login"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "crypted_password"
    t.string   "remember_token"
    t.datetime "remember_token_expires_at"
    t.integer  "member_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["member_id"], name: "index_users_on_member_id", using: :btree

  create_table "verifications", force: true do |t|
    t.string   "pan_id"
    t.string   "tax_id"
    t.string   "address_id"
    t.string   "tan_id"
    t.integer  "center_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
