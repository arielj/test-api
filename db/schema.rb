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

ActiveRecord::Schema.define(version: 2019_03_27_154045) do

  create_table "movies", force: :cascade do |t|
    t.string "title"
    t.integer "release_year"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "movies_people", id: false, force: :cascade do |t|
    t.integer "movie_id"
    t.integer "person_id"
    t.integer "role"
    t.index ["movie_id"], name: "index_movies_people_on_movie_id"
    t.index ["person_id"], name: "index_movies_people_on_person_id"
  end

  create_table "people", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.text "aliases"
    t.integer "gender"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "login"
    t.string "password_digest"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
