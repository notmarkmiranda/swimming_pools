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

ActiveRecord::Schema.define(version: 2021_02_07_024335) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "choices", force: :cascade do |t|
    t.bigint "question_id", null: false
    t.string "text"
    t.boolean "correct"
    t.integer "points", default: 1
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["question_id"], name: "index_choices_on_question_id"
  end

  create_table "entries", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "pool_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["pool_id"], name: "index_entries_on_pool_id"
    t.index ["user_id"], name: "index_entries_on_user_id"
  end

  create_table "memberships", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "pool_id", null: false
    t.integer "role", default: 0
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["pool_id"], name: "index_memberships_on_pool_id"
    t.index ["user_id"], name: "index_memberships_on_user_id"
  end

  create_table "picks", force: :cascade do |t|
    t.bigint "entry_id", null: false
    t.bigint "choice_id", null: false
    t.boolean "correct"
    t.integer "points", default: 1
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["choice_id"], name: "index_picks_on_choice_id"
    t.index ["entry_id"], name: "index_picks_on_entry_id"
  end

  create_table "pools", force: :cascade do |t|
    t.string "name"
    t.string "associated_game"
    t.date "date"
    t.boolean "multiple_entries"
    t.boolean "completed", default: false
    t.bigint "user_id", null: false
    t.string "invite_code"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_pools_on_user_id"
  end

  create_table "questions", force: :cascade do |t|
    t.bigint "pool_id", null: false
    t.string "text"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["pool_id"], name: "index_questions_on_pool_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "first_name"
    t.string "last_initial"
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "choices", "questions"
  add_foreign_key "entries", "pools"
  add_foreign_key "entries", "users"
  add_foreign_key "memberships", "pools"
  add_foreign_key "memberships", "users"
  add_foreign_key "picks", "choices"
  add_foreign_key "picks", "entries"
  add_foreign_key "pools", "users"
  add_foreign_key "questions", "pools"
end
