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

ActiveRecord::Schema.define(version: 20150620055913) do

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

  create_table "active_admin_comments", force: true do |t|
    t.string   "namespace"
    t.text     "body"
    t.string   "resource_id",   null: false
    t.string   "resource_type", null: false
    t.integer  "author_id"
    t.string   "author_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "active_admin_comments", ["author_type", "author_id"], name: "index_active_admin_comments_on_author_type_and_author_id", using: :btree
  add_index "active_admin_comments", ["namespace"], name: "index_active_admin_comments_on_namespace", using: :btree
  add_index "active_admin_comments", ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource_type_and_resource_id", using: :btree

  create_table "areas", force: true do |t|
    t.integer  "city_id"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

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
    t.integer  "center_id"
    t.integer  "partner_id"
    t.integer  "service_type", default: 1
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
    t.string   "slug"
  end

  add_index "categories", ["slug"], name: "index_categories_on_slug", unique: true, using: :btree

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
    t.string   "address"
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

  create_table "centermen", force: true do |t|
    t.string   "email"
    t.integer  "user_id"
    t.integer  "center_id"
    t.string   "photo_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "centers", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
    t.integer  "partner_id"
    t.integer  "city_id"
    t.integer  "area_id"
    t.string   "slug"
    t.string   "status",      default: "inactive"
    t.string   "place_id"
    t.string   "place_name"
    t.string   "center_type"
    t.string   "image_id"
  end

  add_index "centers", ["partner_id"], name: "index_centers_on_partner_id", using: :btree
  add_index "centers", ["slug"], name: "index_centers_on_slug", unique: true, using: :btree

  create_table "centers_experiences", id: false, force: true do |t|
    t.integer "center_id"
    t.integer "experience_id"
  end

  add_index "centers_experiences", ["center_id"], name: "index_centers_experiences_on_center_id", using: :btree
  add_index "centers_experiences", ["experience_id"], name: "index_centers_experiences_on_experience_id", using: :btree

  create_table "centers_facilities", id: false, force: true do |t|
    t.integer "center_id"
    t.integer "facility_id"
  end

  add_index "centers_facilities", ["center_id"], name: "index_centers_facilities_on_center_id", using: :btree
  add_index "centers_facilities", ["facility_id"], name: "index_centers_facilities_on_facility_id", using: :btree

  create_table "centers_fpclasses", force: true do |t|
    t.integer "center_id"
    t.integer "fpclass_id"
  end

  add_index "centers_fpclasses", ["center_id"], name: "index_centers_fpclasses_on_center_id", using: :btree
  add_index "centers_fpclasses", ["fpclass_id"], name: "index_centers_fpclasses_on_fpclass_id", using: :btree

  create_table "centertypes", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "cities", force: true do |t|
    t.string   "name"
    t.string   "state"
    t.string   "classification"
    t.string   "population"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "clasbkings", force: true do |t|
    t.integer  "customer_id"
    t.integer  "fpclass_id"
    t.integer  "passport_id"
    t.string   "status"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.date     "expired_at"
    t.integer  "center_id"
  end

  add_index "clasbkings", ["center_id"], name: "index_clasbkings_on_center_id", using: :btree
  add_index "clasbkings", ["customer_id"], name: "index_clasbkings_on_customer_id", using: :btree
  add_index "clasbkings", ["fpclass_id"], name: "index_clasbkings_on_fpclass_id", using: :btree
  add_index "clasbkings", ["passport_id"], name: "index_clasbkings_on_passport_id", using: :btree

  create_table "commissions", force: true do |t|
    t.float    "val"
    t.integer  "center_id"
    t.integer  "partner_id"
    t.integer  "service_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "commontator_comments", force: true do |t|
    t.string   "creator_type"
    t.integer  "creator_id"
    t.string   "editor_type"
    t.integer  "editor_id"
    t.integer  "thread_id",                     null: false
    t.text     "body",                          null: false
    t.datetime "deleted_at"
    t.integer  "cached_votes_up",   default: 0
    t.integer  "cached_votes_down", default: 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "commontator_comments", ["cached_votes_down"], name: "index_commontator_comments_on_cached_votes_down", using: :btree
  add_index "commontator_comments", ["cached_votes_up"], name: "index_commontator_comments_on_cached_votes_up", using: :btree
  add_index "commontator_comments", ["creator_id", "creator_type", "thread_id"], name: "index_commontator_comments_on_c_id_and_c_type_and_t_id", using: :btree
  add_index "commontator_comments", ["thread_id", "created_at"], name: "index_commontator_comments_on_thread_id_and_created_at", using: :btree

  create_table "commontator_subscriptions", force: true do |t|
    t.string   "subscriber_type", null: false
    t.integer  "subscriber_id",   null: false
    t.integer  "thread_id",       null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "commontator_subscriptions", ["subscriber_id", "subscriber_type", "thread_id"], name: "index_commontator_subscriptions_on_s_id_and_s_type_and_t_id", unique: true, using: :btree
  add_index "commontator_subscriptions", ["thread_id"], name: "index_commontator_subscriptions_on_thread_id", using: :btree

  create_table "commontator_threads", force: true do |t|
    t.string   "commontable_type"
    t.integer  "commontable_id"
    t.datetime "closed_at"
    t.string   "closer_type"
    t.integer  "closer_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "commontator_threads", ["commontable_id", "commontable_type"], name: "index_commontator_threads_on_c_id_and_c_type", unique: true, using: :btree

  create_table "coupons", force: true do |t|
    t.string   "code",                                                  null: false
    t.decimal  "amount",        precision: 8, scale: 2, default: 0.0
    t.decimal  "minimul_value", precision: 8, scale: 2
    t.integer  "percent",                               default: 0
    t.boolean  "combine",                               default: false
    t.datetime "starts_at"
    t.datetime "expires_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "coupons", ["code"], name: "index_coupons_on_code", using: :btree
  add_index "coupons", ["expires_at"], name: "index_coupons_on_expires_at", using: :btree

  create_table "cphotos", force: true do |t|
    t.string   "image_id"
    t.integer  "centerinfo_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "center_id"
  end

  create_table "customers", force: true do |t|
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
  end

  create_table "delayed_jobs", force: true do |t|
    t.integer  "priority",   default: 0, null: false
    t.integer  "attempts",   default: 0, null: false
    t.text     "handler",                null: false
    t.text     "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by"
    t.string   "queue"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "delayed_jobs", ["priority", "run_at"], name: "delayed_jobs_priority", using: :btree

  create_table "details", force: true do |t|
    t.string   "gender"
    t.string   "name"
    t.boolean  "kid"
    t.string   "mobile"
    t.text     "request"
    t.integer  "booking_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "experiences", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "facilities", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "fpclasses", force: true do |t|
    t.string   "name"
    t.date     "date"
    t.string   "duration"
    t.integer  "seats"
    t.integer  "instructor_id"
    t.string   "type_of"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "partner_id"
    t.boolean  "recurring",     default: false
    t.integer  "interval"
    t.string   "rule_type"
    t.integer  "week_start"
    t.text     "description"
    t.string   "level"
    t.string   "slug"
    t.date     "expiry"
    t.time     "start_time"
  end

  add_index "fpclasses", ["instructor_id"], name: "index_fpclasses_on_instructor_id", using: :btree
  add_index "fpclasses", ["slug"], name: "index_fpclasses_on_slug", unique: true, using: :btree

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

  create_table "identities", force: true do |t|
    t.integer  "customer_id"
    t.string   "provider"
    t.string   "uid"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "identities", ["customer_id"], name: "index_identities_on_customer_id", using: :btree

  create_table "infos", force: true do |t|
    t.string   "ac_no"
    t.string   "bank_name"
    t.string   "ifsc"
    t.string   "bank_address"
    t.string   "bank_location"
    t.string   "pan"
    t.string   "service_tax"
    t.string   "panproof"
    t.string   "idproof"
    t.string   "taxproof"
    t.integer  "partner_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "infos", ["partner_id"], name: "index_infos_on_partner_id", using: :btree

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
    t.integer  "partner_id"
  end

  add_index "instructors", ["center_id"], name: "index_instructors_on_center_id", using: :btree

  create_table "invoices", force: true do |t|
    t.integer  "order_id",                                                  null: false
    t.decimal  "amount",       precision: 8, scale: 2,                      null: false
    t.string   "invoice_type",                         default: "Purchase", null: false
    t.string   "state",                                                     null: false
    t.boolean  "active",                               default: true,       null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "number"
  end

  add_index "invoices", ["order_id"], name: "index_invoices_on_order_id", using: :btree

  create_table "monologue_posts", force: true do |t|
    t.boolean  "published"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.string   "title"
    t.text     "content"
    t.string   "url"
    t.datetime "published_at"
  end

  add_index "monologue_posts", ["url"], name: "index_monologue_posts_on_url", unique: true, using: :btree

  create_table "monologue_taggings", force: true do |t|
    t.integer "post_id"
    t.integer "tag_id"
  end

  add_index "monologue_taggings", ["post_id"], name: "index_monologue_taggings_on_post_id", using: :btree
  add_index "monologue_taggings", ["tag_id"], name: "index_monologue_taggings_on_tag_id", using: :btree

  create_table "monologue_tags", force: true do |t|
    t.string "name"
  end

  add_index "monologue_tags", ["name"], name: "index_monologue_tags_on_name", using: :btree

  create_table "monologue_users", force: true do |t|
    t.string   "name"
    t.string   "email"
    t.string   "password_digest"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

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

  create_table "order_items", force: true do |t|
    t.integer  "order_id"
    t.integer  "quantity"
    t.decimal  "unit_price", precision: 8, scale: 2
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "service_id"
    t.integer  "center_id"
    t.string   "order_type",                         default: "Service"
  end

  create_table "orders", force: true do |t|
    t.string   "token"
    t.string   "email_address"
    t.string   "phone_number"
    t.string   "status"
    t.string   "ip_address"
    t.decimal  "amount_paid",      precision: 8, scale: 2
    t.string   "invoice_number"
    t.integer  "service_id"
    t.integer  "center_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "number"
    t.string   "bank_ref_num"
    t.string   "bankcode"
    t.string   "name_on_card"
    t.string   "cardnum"
    t.string   "amount_split"
    t.string   "payuMoneyId"
    t.string   "discount"
    t.string   "net_amount_debit"
    t.integer  "customer_id"
    t.integer  "coupon_id"
  end

  add_index "orders", ["coupon_id"], name: "index_orders_on_coupon_id", using: :btree
  add_index "orders", ["customer_id"], name: "index_orders_on_customer_id", using: :btree

  create_table "overall_averages", force: true do |t|
    t.integer  "rateable_id"
    t.string   "rateable_type"
    t.float    "overall_avg",   null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "overall_averages", ["rateable_id", "rateable_type"], name: "index_overall_averages_on_rateable_id_and_rateable_type", using: :btree

  create_table "packages", force: true do |t|
    t.integer  "customer_id"
    t.string   "status"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "token"
  end

  add_index "packages", ["customer_id"], name: "index_packages_on_customer_id", using: :btree

  create_table "partners", force: true do |t|
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "business_name"
    t.integer  "category_id"
    t.integer  "user_id"
    t.string   "partner_type"
  end

  create_table "passports", force: true do |t|
    t.date     "start_date"
    t.date     "end_date"
    t.integer  "order_item_id"
    t.integer  "customer_id"
    t.integer  "tickets"
    t.integer  "active"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "passports", ["customer_id"], name: "index_passports_on_customer_id", using: :btree
  add_index "passports", ["order_item_id"], name: "index_passports_on_order_item_id", using: :btree

  create_table "percents", force: true do |t|
    t.float    "val"
    t.integer  "center_id"
    t.integer  "partner_id"
    t.integer  "service_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "populars", force: true do |t|
    t.integer  "center_id"
    t.integer  "partner_id"
    t.integer  "rank"
    t.integer  "category_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "populars", ["category_id"], name: "index_populars_on_category_id", using: :btree
  add_index "populars", ["center_id"], name: "index_populars_on_center_id", using: :btree
  add_index "populars", ["partner_id"], name: "index_populars_on_partner_id", using: :btree

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

  create_table "recursivedates", force: true do |t|
    t.date     "ondate"
    t.integer  "fpclass_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "recursivedates", ["fpclass_id"], name: "index_recursivedates_on_fpclass_id", using: :btree

  create_table "services", force: true do |t|
    t.integer  "center_id"
    t.integer  "category_id"
    t.string   "service_type"
    t.string   "name"
    t.string   "time_taken"
    t.float    "original_price"
    t.float    "selling_price"
    t.integer  "gender_id"
    t.string   "schedule"
    t.datetime "start_date"
    t.datetime "end_date"
    t.integer  "seats"
    t.boolean  "active"
    t.text     "service_desc"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "days"
    t.integer  "validity"
    t.integer  "expired_on"
    t.string   "slug"
  end

  add_index "services", ["category_id"], name: "index_services_on_category_id", using: :btree
  add_index "services", ["center_id"], name: "index_services_on_center_id", using: :btree
  add_index "services", ["slug"], name: "index_services_on_slug", unique: true, using: :btree

  create_table "services_instructors", id: false, force: true do |t|
    t.integer "service_id"
    t.integer "instructor_id"
  end

  add_index "services_instructors", ["instructor_id"], name: "index_services_instructors_on_instructor_id", using: :btree
  add_index "services_instructors", ["service_id"], name: "index_services_instructors_on_service_id", using: :btree

  create_table "superadmins", force: true do |t|
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
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
    t.boolean  "active",                    default: false
    t.string   "phone"
    t.string   "emergency_name"
    t.string   "emergency_phone"
    t.integer  "centertype_id"
    t.string   "address1"
    t.string   "address2"
    t.string   "country"
    t.string   "image_id"
    t.string   "uid"
    t.string   "password_reset_token"
    t.datetime "password_reset_sent_at"
    t.integer  "city_id"
    t.integer  "area_id"
    t.string   "location"
    t.date     "dob"
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
