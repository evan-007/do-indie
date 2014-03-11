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

ActiveRecord::Schema.define(version: 20140311060734) do

  create_table "band_managers", force: true do |t|
    t.integer  "user_id"
    t.integer  "band_id"
    t.boolean  "approved",   default: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "band_managers", ["band_id"], name: "index_band_managers_on_band_id"
  add_index "band_managers", ["user_id"], name: "index_band_managers_on_user_id"

  create_table "bands", force: true do |t|
    t.string   "name"
    t.string   "contact"
    t.string   "facebook"
    t.string   "twitter"
    t.string   "site"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "korean_name"
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.string   "label"
    t.string   "genre"
    t.string   "myspace"
    t.string   "bandcamp"
    t.string   "cafe"
    t.string   "itunes"
    t.string   "soundcloud"
    t.string   "youtube"
    t.string   "photo_url"
  end

  create_table "event_bands", force: true do |t|
    t.integer  "band_id"
    t.integer  "event_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "event_bands", ["band_id"], name: "index_event_bands_on_band_id"
  add_index "event_bands", ["event_id"], name: "index_event_bands_on_event_id"

  create_table "event_venues", force: true do |t|
    t.integer  "venue_id"
    t.integer  "event_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "event_venues", ["event_id"], name: "index_event_venues_on_event_id"
  add_index "event_venues", ["venue_id"], name: "index_event_venues_on_venue_id"

  create_table "events", force: true do |t|
    t.string   "name"
    t.string   "contact"
    t.string   "price"
    t.text     "info"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.date     "date"
    t.string   "time"
    t.integer  "venue_id"
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.string   "ko_name"
    t.string   "facebook"
    t.boolean  "ticket"
    t.string   "ticket_price"
    t.string   "door_price"
    t.string   "ticket_url"
    t.text     "info_ko"
  end

  add_index "events", ["venue_id"], name: "index_events_on_venue_id"

  create_table "friendly_id_slugs", force: true do |t|
    t.string   "slug",                      null: false
    t.integer  "sluggable_id",              null: false
    t.string   "sluggable_type", limit: 50
    t.string   "scope"
    t.datetime "created_at"
  end

  add_index "friendly_id_slugs", ["slug", "sluggable_type", "scope"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope", unique: true
  add_index "friendly_id_slugs", ["slug", "sluggable_type"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type"
  add_index "friendly_id_slugs", ["sluggable_id"], name: "index_friendly_id_slugs_on_sluggable_id"
  add_index "friendly_id_slugs", ["sluggable_type"], name: "index_friendly_id_slugs_on_sluggable_type"

  create_table "user_fans", force: true do |t|
    t.integer  "band_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "user_fans", ["band_id"], name: "index_user_fans_on_band_id"
  add_index "user_fans", ["user_id"], name: "index_user_fans_on_user_id"

  create_table "users", force: true do |t|
    t.string   "username",               default: "",    null: false
    t.string   "email",                  default: "",    null: false
    t.string   "encrypted_password",     default: "",    null: false
    t.boolean  "admin",                  default: false, null: false
    t.boolean  "locked",                 default: false, null: false
    t.string   "slug"
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  add_index "users", ["slug"], name: "index_users_on_slug", unique: true
  add_index "users", ["username"], name: "index_users_on_username", unique: true

  create_table "venue_managers", force: true do |t|
    t.integer  "user_id"
    t.integer  "venue_id"
    t.boolean  "approved",   default: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "venue_managers", ["user_id"], name: "index_venue_managers_on_user_id"
  add_index "venue_managers", ["venue_id"], name: "index_venue_managers_on_venue_id"

  create_table "venues", force: true do |t|
    t.string   "name"
    t.string   "phone"
    t.text     "address"
    t.text     "misc"
    t.string   "facebook"
    t.string   "cafe"
    t.string   "website"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "area"
    t.float    "latitude"
    t.float    "longitude"
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.string   "korean_name"
    t.string   "city_en"
    t.string   "city_ko"
    t.string   "email"
    t.string   "twitter"
  end

end
