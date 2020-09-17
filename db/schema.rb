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

ActiveRecord::Schema.define(version: 2020_09_17_005127) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "answers", force: :cascade do |t|
    t.string "answer"
    t.bigint "post_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["post_id"], name: "index_answers_on_post_id"
  end

  create_table "connections", force: :cascade do |t|
    t.bigint "mentee_id", null: false
    t.bigint "mentor_id", null: false
    t.boolean "accepted", default: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["mentee_id"], name: "index_connections_on_mentee_id"
    t.index ["mentor_id"], name: "index_connections_on_mentor_id"
  end

  create_table "posts", force: :cascade do |t|
    t.bigint "connection_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["connection_id"], name: "index_posts_on_connection_id"
  end

  create_table "questions", force: :cascade do |t|
    t.string "question"
    t.bigint "post_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["post_id"], name: "index_questions_on_post_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "username"
    t.string "password"
    t.string "birthdate"
    t.string "gender"
    t.string "avatar"
    t.string "prof_q1"
    t.string "prof_q2"
    t.string "prof_q3"
    t.integer "karma"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  add_foreign_key "answers", "posts"
  add_foreign_key "connections", "users", column: "mentee_id"
  add_foreign_key "connections", "users", column: "mentor_id"
  add_foreign_key "posts", "connections"
  add_foreign_key "questions", "posts"
end
