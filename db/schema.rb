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

ActiveRecord::Schema.define(version: 20160923172829) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "games", force: :cascade do |t|
    t.string   "title"
    t.float    "cpu"
    t.float    "gpu"
    t.float    "ram"
    t.float    "size"
    t.datetime "approval_date"
    t.string   "current_status"
    t.text     "stats"
    t.integer  "user_id"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.integer  "status_id"
    t.text     "description"
    t.string   "picture"
    t.string   "link"
    t.string   "attachment"
    t.string   "aasm_state"
    t.json     "key_map"
    t.index ["status_id"], name: "index_games_on_status_id", using: :btree
    t.index ["user_id"], name: "index_games_on_user_id", using: :btree
  end

  create_table "loads", force: :cascade do |t|
    t.integer  "game_id"
    t.integer  "machine_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["game_id"], name: "index_loads_on_game_id", using: :btree
    t.index ["machine_id"], name: "index_loads_on_machine_id", using: :btree
  end

  create_table "locations", force: :cascade do |t|
    t.string   "name"
    t.text     "address"
    t.string   "city"
    t.string   "postal_code"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.string   "run_status"
  end

  create_table "machines", force: :cascade do |t|
    t.integer  "location_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["location_id"], name: "index_machines_on_location_id", using: :btree
  end

  create_table "messages", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "content"
    t.string   "email"
  end

  create_table "pg_search_documents", force: :cascade do |t|
    t.text     "content"
    t.string   "searchable_type"
    t.integer  "searchable_id"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.index ["searchable_type", "searchable_id"], name: "index_pg_search_documents_on_searchable_type_and_searchable_id", using: :btree
  end

  create_table "reviews", force: :cascade do |t|
    t.integer  "fun"
    t.integer  "playability"
    t.integer  "difficulty"
    t.integer  "load_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.integer  "game_id"
    t.index ["game_id"], name: "index_reviews_on_game_id", using: :btree
    t.index ["load_id"], name: "index_reviews_on_load_id", using: :btree
  end

  create_table "statuses", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "taggings", force: :cascade do |t|
    t.integer  "game_id"
    t.integer  "tag_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["game_id"], name: "index_taggings_on_game_id", using: :btree
    t.index ["tag_id"], name: "index_taggings_on_tag_id", using: :btree
  end

  create_table "tags", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "company"
    t.string   "email"
    t.string   "password_digest"
    t.string   "logo"
    t.integer  "employees"
    t.string   "genres"
    t.string   "website"
    t.string   "twitter"
    t.boolean  "admin"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  add_foreign_key "games", "users"
  add_foreign_key "loads", "games"
  add_foreign_key "loads", "machines"
  add_foreign_key "machines", "locations"
  add_foreign_key "reviews", "games"
  add_foreign_key "reviews", "loads"
  add_foreign_key "taggings", "games"
  add_foreign_key "taggings", "tags"
end
