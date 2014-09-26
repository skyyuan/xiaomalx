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

ActiveRecord::Schema.define(version: 20140924071120) do

  create_table "advisory_informations", force: true do |t|
    t.string   "destination"
    t.string   "education"
    t.string   "professional"
    t.string   "funds"
    t.string   "school"
    t.string   "studying_professional"
    t.string   "gpa"
    t.string   "text_type"
    t.string   "results"
    t.string   "ranking"
    t.string   "academic"
    t.string   "employment"
    t.string   "resettlement"
    t.string   "preference"
    t.integer  "elder_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "answers", force: true do |t|
    t.string   "title"
    t.integer  "question_id"
    t.integer  "object_id"
    t.integer  "consultant",     default: 0
    t.integer  "praise",         default: 0
    t.integer  "parent_id"
    t.integer  "lft"
    t.integer  "rgt"
    t.integer  "depth"
    t.integer  "children_count", default: 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "categories", force: true do |t|
    t.string   "name"
    t.integer  "parent_id"
    t.integer  "lft"
    t.integer  "rgt"
    t.integer  "depth"
    t.integer  "children_count", default: 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "curriculums", force: true do |t|
    t.integer  "student_id"
    t.string   "course_title"
    t.text     "course_content"
    t.date     "course_date"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.string   "arrival_school"
    t.string   "leave_school"
  end

  create_table "elders", force: true do |t|
    t.string   "nickname"
    t.string   "password"
    t.string   "phone"
    t.string   "open_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "elective_registrations", force: true do |t|
    t.integer  "student_id"
    t.integer  "elective_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "electives", force: true do |t|
    t.string   "course_name"
    t.date     "lesson_date"
    t.string   "lesson_venue"
    t.string   "course_introduction"
    t.string   "lesson_duration"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "individual_lessons", force: true do |t|
    t.integer  "student_id"
    t.integer  "student_admin_id"
    t.string   "lesson_name"
    t.string   "course_name"
    t.string   "teacher_name"
    t.string   "lesson_venue"
    t.string   "class_room"
    t.date     "lesson_date"
    t.string   "lesson_duration"
    t.text     "teacher_evaluate"
    t.integer  "curriculum_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "messages", force: true do |t|
    t.integer  "student_id"
    t.integer  "state"
    t.integer  "curriculum_id"
    t.integer  "is_check",      default: 0
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "msg_content"
  end

  create_table "question_tags", force: true do |t|
    t.integer  "question_id"
    t.integer  "level_id"
    t.integer  "country_id"
    t.integer  "profe_id"
    t.integer  "other_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "questions", force: true do |t|
    t.string   "title"
    t.integer  "elder_id"
    t.integer  "preview",      default: 0
    t.integer  "answer_count", default: 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "student_admins", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "name"
    t.string   "phone"
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "student_admins", ["email"], name: "index_student_admins_on_email", unique: true, using: :btree
  add_index "student_admins", ["reset_password_token"], name: "index_student_admins_on_reset_password_token", unique: true, using: :btree

  create_table "students", force: true do |t|
    t.integer  "student_admin_id"
    t.string   "student_name"
    t.string   "student_picture"
    t.string   "account"
    t.string   "password"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.integer  "school_hour"
    t.string   "school_district"
    t.string   "student_type"
    t.string   "identifying_code"
  end

  create_table "supplement_lessons", force: true do |t|
    t.integer  "student_id"
    t.integer  "student_admin_id"
    t.string   "lesson_name"
    t.string   "course_name"
    t.string   "teacher_name"
    t.string   "lesson_venue"
    t.string   "class_room"
    t.date     "lesson_date"
    t.string   "lesson_duration"
    t.text     "student_score"
    t.integer  "curriculum_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
