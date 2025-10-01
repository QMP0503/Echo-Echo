# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[8.0].define(version: 2025_10_01_173355) do
  create_table "classrooms", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "echo_dates", force: :cascade do |t|
    t.integer "echo_id", null: false
    t.date "date", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["date", "echo_id"], name: "index_echo_dates_on_date_and_echo_id", unique: true
    t.index ["date"], name: "index_echo_dates_on_date"
    t.index ["echo_id"], name: "index_echo_dates_on_echo_id"
  end

  create_table "echos", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "classroom_id", null: false
    t.boolean "private", default: false, null: false
    t.index ["classroom_id"], name: "index_echos_on_classroom_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email"
    t.string "encrypted_password"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "user_type", default: "student", null: false
    t.integer "classroom_id", null: false
    t.index ["classroom_id"], name: "index_users_on_classroom_id"
  end

  add_foreign_key "echo_dates", "echos"
  add_foreign_key "echos", "classrooms"
  add_foreign_key "users", "classrooms"
end
