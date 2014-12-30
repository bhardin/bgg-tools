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

ActiveRecord::Schema.define(version: 20141230194504) do

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

  create_table "games", force: true do |t|
    t.string   "name"
    t.integer  "bgg_id"
    t.string   "new_price"
    t.string   "like_new_price"
    t.string   "very_good_price"
    t.string   "good_price"
    t.string   "acceptable_price"
    t.string   "average_price"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "thumbnail"
    t.string   "image"
    t.text     "description"
    t.integer  "min_players"
    t.integer  "max_players"
    t.integer  "year_published"
    t.integer  "minimum_age"
    t.integer  "playing_time"
    t.text     "polls"
    t.float    "median_price"
    t.float    "mean_price"
  end

  add_index "games", ["bgg_id"], name: "index_games_on_bgg_id", unique: true, using: :btree

  create_table "historical_prices", force: true do |t|
    t.integer  "game_id"
    t.date     "date_sold"
    t.float    "price"
    t.string   "currency"
    t.string   "condition"
    t.string   "link"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users_games", id: false, force: true do |t|
    t.integer "game_id", null: false
    t.integer "user_id", null: false
  end

  add_index "users_games", ["game_id"], name: "index_users_games_on_game_id", using: :btree
  add_index "users_games", ["user_id"], name: "index_users_games_on_user_id", using: :btree

end
