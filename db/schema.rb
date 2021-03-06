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

ActiveRecord::Schema.define(version: 2021_02_20_143747) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "teams", force: :cascade do |t|
    t.string "domain", limit: 320
    t.string "slack_id", limit: 320, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "oauth_token"
    t.string "name"
    t.string "channel", null: false
    t.string "channel_id", null: false
    t.index ["slack_id"], name: "index_teams_on_slack_id", unique: true
  end

  create_table "users", force: :cascade do |t|
    t.string "name", limit: 320, null: false
    t.string "slack_id", limit: 320, null: false
    t.bigint "team_id", null: false
    t.datetime "birthday", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["slack_id"], name: "index_users_on_slack_id", unique: true
    t.index ["team_id"], name: "index_users_on_team_id"
  end

  add_foreign_key "users", "teams"
end
