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

ActiveRecord::Schema.define(version: 20140401100846) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "pg_trgm"

  create_table "band_genres", force: true do |t|
    t.integer  "band_id"
    t.integer  "genre_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "band_genres", ["band_id"], name: "index_band_genres_on_band_id", using: :btree
  add_index "band_genres", ["genre_id"], name: "index_band_genres_on_genre_id", using: :btree

  create_table "band_managers", force: true do |t|
    t.integer  "user_id"
    t.integer  "band_id"
    t.boolean  "approved",   default: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "band_managers", ["band_id"], name: "index_band_managers_on_band_id", using: :btree
  add_index "band_managers", ["user_id"], name: "index_band_managers_on_user_id", using: :btree

  create_table "bands", force: true do |t|
    t.string   "name"
    t.string   "contact"
    t.string   "facebook"
    t.string   "twitter"
    t.string   "site"
    t.text     "en_bio"
    t.text     "ko_bio"
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
    t.string   "slug"
    t.boolean  "approved",            default: false
    t.integer  "user_id"
  end

  add_index "bands", ["user_id"], name: "index_bands_on_user_id", using: :btree

  create_table "cities", force: true do |t|
    t.string   "en_name"
    t.string   "ko_name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "ckeditor_assets", force: true do |t|
    t.string   "data_file_name",               null: false
    t.string   "data_content_type"
    t.integer  "data_file_size"
    t.integer  "assetable_id"
    t.string   "assetable_type",    limit: 30
    t.string   "type",              limit: 30
    t.integer  "width"
    t.integer  "height"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "ckeditor_assets", ["assetable_type", "assetable_id"], name: "idx_ckeditor_assetable", using: :btree
  add_index "ckeditor_assets", ["assetable_type", "type", "assetable_id"], name: "idx_ckeditor_assetable_type", using: :btree

  create_table "event_bands", force: true do |t|
    t.integer  "band_id"
    t.integer  "event_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "event_bands", ["band_id"], name: "index_event_bands_on_band_id", using: :btree
  add_index "event_bands", ["event_id"], name: "index_event_bands_on_event_id", using: :btree

  create_table "event_managers", force: true do |t|
    t.integer  "user_id"
    t.integer  "event_id"
    t.boolean  "approved",   default: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "event_managers", ["event_id"], name: "index_event_managers_on_event_id", using: :btree
  add_index "event_managers", ["user_id"], name: "index_event_managers_on_user_id", using: :btree

  create_table "event_venues", force: true do |t|
    t.integer  "venue_id"
    t.integer  "event_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "event_venues", ["event_id"], name: "index_event_venues_on_event_id", using: :btree
  add_index "event_venues", ["venue_id"], name: "index_event_venues_on_venue_id", using: :btree

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
    t.string   "slug"
    t.boolean  "approved",            default: false
    t.integer  "user_id"
  end

  add_index "events", ["user_id"], name: "index_events_on_user_id", using: :btree
  add_index "events", ["venue_id"], name: "index_events_on_venue_id", using: :btree

  create_table "friendly_id_slugs", force: true do |t|
    t.string   "slug",                      null: false
    t.integer  "sluggable_id",              null: false
    t.string   "sluggable_type", limit: 50
    t.string   "scope"
    t.datetime "created_at"
  end

  add_index "friendly_id_slugs", ["slug", "sluggable_type", "scope"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope", unique: true, using: :btree
  add_index "friendly_id_slugs", ["slug", "sluggable_type"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type", using: :btree
  add_index "friendly_id_slugs", ["sluggable_id"], name: "index_friendly_id_slugs_on_sluggable_id", using: :btree
  add_index "friendly_id_slugs", ["sluggable_type"], name: "index_friendly_id_slugs_on_sluggable_type", using: :btree

  create_table "genres", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "posts", force: true do |t|
    t.text     "title"
    t.text     "en_body"
    t.text     "ko_body"
    t.string   "short_title"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "published"
    t.string   "slug"
    t.string   "ko_title"
  end

  create_table "slides", force: true do |t|
    t.string   "en_title"
    t.string   "ko_title"
    t.text     "en_description"
    t.text     "ko_description"
    t.boolean  "active",             default: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.string   "link"
    t.string   "anchor"
  end

  create_table "user_fans", force: true do |t|
    t.integer  "band_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "user_fans", ["band_id"], name: "index_user_fans_on_band_id", using: :btree
  add_index "user_fans", ["user_id"], name: "index_user_fans_on_user_id", using: :btree

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
    t.boolean  "blogger",                default: false
    t.string   "provider"
    t.string   "uid"
    t.boolean  "mailing_list",           default: false
  end

  add_index "users", ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true, using: :btree
  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  add_index "users", ["slug"], name: "index_users_on_slug", unique: true, using: :btree
  add_index "users", ["username"], name: "index_users_on_username", unique: true, using: :btree

  create_table "venue_cities", force: true do |t|
    t.integer  "venue_id"
    t.integer  "city_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "venue_cities", ["city_id"], name: "index_venue_cities_on_city_id", using: :btree
  add_index "venue_cities", ["venue_id"], name: "index_venue_cities_on_venue_id", using: :btree

  create_table "venue_managers", force: true do |t|
    t.integer  "user_id"
    t.integer  "venue_id"
    t.boolean  "approved",   default: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "venue_managers", ["user_id"], name: "index_venue_managers_on_user_id", using: :btree
  add_index "venue_managers", ["venue_id"], name: "index_venue_managers_on_venue_id", using: :btree

  create_table "venues", force: true do |t|
    t.string   "name"
    t.string   "phone"
    t.text     "address"
    t.text     "en_bio"
    t.text     "ko_bio"
    t.string   "facebook"
    t.string   "cafe"
    t.string   "website"
    t.string   "small_map"
    t.text     "en_directions"
    t.text     "ko_directions"
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
    t.string   "minimap_file_name"
    t.string   "minimap_content_type"
    t.integer  "minimap_file_size"
    t.datetime "minimap_updated_at"
    t.string   "slug"
    t.boolean  "approved",             default: false
    t.integer  "user_id"
    t.string   "ko_name"
  end

  add_index "venues", ["user_id"], name: "index_venues_on_user_id", using: :btree

end
