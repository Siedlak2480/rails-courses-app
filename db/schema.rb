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

ActiveRecord::Schema[8.0].define(version: 2025_08_15_210744) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "courses", force: :cascade do |t|
    t.string "title", null: false
    t.text "description"
    t.bigint "place_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["place_id", "title"], name: "index_courses_on_place_id_and_title"
    t.index ["place_id"], name: "index_courses_on_place_id"
  end

  create_table "participants", force: :cascade do |t|
    t.string "name", null: false
    t.string "email", null: false
    t.bigint "course_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["course_id", "email"], name: "index_participants_on_course_id_and_email", unique: true
    t.index ["course_id"], name: "index_participants_on_course_id"
  end

  create_table "places", force: :cascade do |t|
    t.string "name", null: false
    t.string "address"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_places_on_name"
  end

  add_foreign_key "courses", "places"
  add_foreign_key "participants", "courses"
end
