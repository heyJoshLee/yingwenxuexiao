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

ActiveRecord::Schema.define(version: 20160808032611) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "article_categories", force: :cascade do |t|
    t.integer  "article_id"
    t.integer  "category_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "articles", force: :cascade do |t|
    t.string   "title"
    t.string   "main_image_url"
    t.integer  "author_id"
    t.integer  "category_id"
    t.text     "body"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "slug"
    t.integer  "user_id"
  end

  create_table "bootsy_image_galleries", force: :cascade do |t|
    t.integer  "bootsy_resource_id"
    t.string   "bootsy_resource_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "bootsy_images", force: :cascade do |t|
    t.string   "image_file"
    t.integer  "image_gallery_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "categories", force: :cascade do |t|
    t.string   "name"
    t.string   "image_url"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "slug"
  end

  create_table "choices", force: :cascade do |t|
    t.integer  "question_id"
    t.boolean  "correct"
    t.text     "body"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "comments", force: :cascade do |t|
    t.text     "body"
    t.integer  "user_id"
    t.integer  "article_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "course_users", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "course_id"
    t.boolean  "completed"
    t.boolean  "enrolled"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "courses", force: :cascade do |t|
    t.string   "name"
    t.text     "description"
    t.string   "main_image_url"
    t.boolean  "premium_course", default: true
    t.string   "slug"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "email_signups", force: :cascade do |t|
    t.string   "page",       default: "not_set"
    t.string   "email"
    t.string   "name",       default: "not_given"
    t.string   "campaign",   default: "not_set"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "grades", force: :cascade do |t|
    t.integer "user_id"
    t.integer "lesson_id"
    t.integer "points"
    t.boolean "completed", default: true
  end

  create_table "lesson_users", force: :cascade do |t|
    t.integer  "lesson_id"
    t.integer  "user_id"
    t.boolean  "completed",  default: true
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "lessons", force: :cascade do |t|
    t.string   "name"
    t.text     "script_english"
    t.text     "script_chinese"
    t.string   "video_url"
    t.string   "notes_url"
    t.text     "description"
    t.integer  "course_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "slug"
    t.integer  "lesson_number"
  end

  create_table "questions", force: :cascade do |t|
    t.integer  "quiz_id"
    t.integer  "value"
    t.text     "body"
    t.string   "slug"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "quizzes", force: :cascade do |t|
    t.integer  "lesson_id"
    t.string   "slug"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "user_questions", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "question_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "choice_id"
  end

  create_table "user_quizzes", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "quiz_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: :cascade do |t|
    t.string   "email"
    t.string   "name"
    t.string   "role",             default: "reader"
    t.string   "membership_level", default: "none"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "password_digest"
  end

end
