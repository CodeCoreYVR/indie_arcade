FactoryGirl.define do
  factory :game do
    association :user, factory: :user
    title {Faker::Hipster.sentence(2)}
    cpu 5000
    gpu 5000
    ram 5000
    size 5000
    description "Valid game description"
    aasm_state "Released to arcade"
  end
end

# t.string   "title"
# t.float    "cpu"
# t.float    "gpu"
# t.float    "ram"
# t.float    "size"
# t.datetime "approval_date"
# t.string   "current_status"
# t.text     "stats"
# t.integer  "user_id"
# t.datetime "created_at",     null: false
# t.datetime "updated_at",     null: false
# t.integer  "status_id"
# t.text     "description"
# t.string   "picture"
# t.string   "link"
# t.string   "attachment"
# t.string   "aasm_state"
# t.json     "key_map"
# t.index ["status_id"], name: "index_games_on_status_id", using: :btree
# t.index ["user_id"], name: "index_games_on_user_id", using: :btree
