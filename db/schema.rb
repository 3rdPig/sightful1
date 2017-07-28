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

ActiveRecord::Schema.define(version: 20170707071417) do

  create_table "addresses", force: :cascade do |t|
    t.integer  "zip"
    t.string   "city"
    t.string   "state"
    t.string   "country"
    t.string   "line_1"
    t.string   "line_2"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "user_id"
  end

  create_table "availabilities", force: :cascade do |t|
    t.integer  "from_day"
    t.integer  "to_day"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "from_time"
    t.datetime "to_time"
  end

  create_table "comments", force: :cascade do |t|
    t.string   "desc",       limit: 4000
    t.integer  "user_id"
    t.integer  "post_id"
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  create_table "educations", force: :cascade do |t|
    t.string   "degree"
    t.string   "unversity"
    t.string   "year_completion"
    t.string   "degree_type"
    t.string   "year_joining"
    t.integer  "user_id"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  create_table "field_lists", force: :cascade do |t|
    t.string   "name"
    t.string   "value"
    t.string   "category"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "fields", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "field"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "follows", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "followee_id"
    t.integer  "follower_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "messages", force: :cascade do |t|
    t.text     "content"
    t.integer  "mentor"
    t.bigint   "ref",        null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "messages", ["ref"], name: "index_messages_on_ref", unique: true

  create_table "notifications", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "to"
    t.integer  "from"
    t.integer  "type"
    t.integer  "body"
    t.integer  "user_id"
  end

  create_table "posts", force: :cascade do |t|
    t.string   "desc",       limit: 400
    t.string   "pic_url"
    t.integer  "user_id"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "schedules", force: :cascade do |t|
    t.integer  "invitee"
    t.datetime "dt"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "status"
    t.integer  "inviter"
    t.integer  "host_id"
    t.bigint   "ref"
  end

  create_table "user_schedules", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "schedule_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "email"
    t.string   "password"
    t.string   "auth"
    t.string   "phone"
    t.integer  "hours"
    t.float    "lat"
    t.float    "lon"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "dp"
    t.boolean  "mentor"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "firtoken"
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "zip"
    t.text     "headline"
    t.string   "location"
    t.string   "current_company"
    t.string   "current_title"
    t.string   "prev_company"
    t.string   "prev_title"
    t.string   "grad_school"
    t.string   "grad_major"
    t.string   "undergrad_school"
    t.string   "undergrad_major"
    t.boolean  "email_confirmed"
    t.string   "confirm_token"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

  create_table "works", force: :cascade do |t|
    t.string   "company"
    t.string   "designation"
    t.string   "year_joining"
    t.string   "month_joining"
    t.string   "year_leaving"
    t.string   "month_leaving"
    t.string   "country"
    t.integer  "user_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.string   "city"
  end

end
