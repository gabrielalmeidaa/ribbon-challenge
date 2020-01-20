# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_01_19_222859) do

  create_table "collected_coins", force: :cascade do |t|
    t.float "value"
    t.integer "user_id"
    t.index ["user_id"], name: "index_collected_coins_on_user_id"
  end

  create_table "deaths", force: :cascade do |t|
    t.integer "user_id"
    t.datetime "timestamp"
    t.index ["user_id"], name: "index_deaths_on_user_id"
  end

  create_table "killed_monsters", force: :cascade do |t|
    t.integer "user_id"
    t.integer "monster_id"
    t.index ["monster_id"], name: "index_killed_monsters_on_monster_id"
    t.index ["user_id"], name: "index_killed_monsters_on_user_id"
  end

  create_table "monsters", force: :cascade do |t|
    t.string "name"
  end

  create_table "trophies", force: :cascade do |t|
    t.integer "user_id"
    t.integer "level"
    t.integer "trophy_type"
    t.index ["user_id"], name: "index_trophies_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.float "total_coins"
    t.float "bowsers_killed"
    t.float "turtles_killed"
    t.float "total_deaths"
  end

  add_foreign_key "collected_coins", "users"
  add_foreign_key "deaths", "users"
  add_foreign_key "killed_monsters", "monsters"
  add_foreign_key "killed_monsters", "users"
  add_foreign_key "trophies", "users"
end
