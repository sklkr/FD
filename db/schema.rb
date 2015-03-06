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

ActiveRecord::Schema.define(version: 20150306053222) do

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
  end

  create_table "bookings", force: true do |t|
    t.integer  "service_id"
    t.integer  "customer_id"
    t.integer  "quantity"
    t.float    "price"
    t.string   "status"
    t.datetime "created_at"
    t.datetime "updated_at"
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

  create_table "centerinfos", force: true do |t|
    t.string   "name"
    t.string   "website"
    t.integer  "brand_photo_gid"
    t.integer  "center_photo_gid"
    t.boolean  "fp_verified"
    t.integer  "hours_id"
    t.integer  "slots"
    t.text     "brief_desc"
    t.text     "detailed_desc"
    t.string   "latitude"
    t.string   "longitude"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "centertype_id"
  end

  create_table "centers", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "centertypes", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "customers", force: true do |t|
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "hours", force: true do |t|
    t.integer  "sun_from"
    t.integer  "mon_from"
    t.integer  "tue_from"
    t.integer  "wed_from"
    t.integer  "thu_from"
    t.integer  "fri_from"
    t.integer  "sat_from"
    t.integer  "sun_to"
    t.integer  "mon_to"
    t.integer  "tue_to"
    t.integer  "wed_to"
    t.integer  "thu_to"
    t.integer  "fri_to"
    t.integer  "sat_to"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "instructors", force: true do |t|
    t.integer  "photo_gid"
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

  create_table "partners", force: true do |t|
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "business_name"
    t.integer  "category_id"
  end

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
    t.string   "type"
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
  end

  create_table "superadmins", force: true do |t|
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "tags", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

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

end
