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

ActiveRecord::Schema.define(version: 20150423220841) do

  create_table "blurbs", force: :cascade do |t|
    t.integer  "user_id",    null: false
    t.text     "content",    null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "blurbs", ["user_id"], name: "index_blurbs_on_user_id"

  create_table "user_followings", force: :cascade do |t|
    t.integer  "follower_id",  null: false
    t.integer  "following_id", null: false
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  add_index "user_followings", ["follower_id", "following_id"], name: "index_user_followings_on_follower_id_and_following_id", unique: true
  add_index "user_followings", ["follower_id"], name: "index_user_followings_on_follower_id"
  add_index "user_followings", ["following_id"], name: "index_user_followings_on_following_id"

  create_table "user_profiles", id: false, force: :cascade do |t|
    t.integer  "user_id",    null: false
    t.string   "username",   null: false
    t.string   "fullname"
    t.text     "bio"
    t.string   "website"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "user_profiles", ["user_id"], name: "index_user_profiles_on_user_id", unique: true
  add_index "user_profiles", ["username"], name: "index_user_profiles_on_username", unique: true

  create_table "users", force: :cascade do |t|
    t.string   "email",           null: false
    t.string   "password_digest", null: false
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true

end
