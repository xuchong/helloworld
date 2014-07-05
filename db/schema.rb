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

ActiveRecord::Schema.define(version: 20140704010632) do

  create_table "answers", force: true do |t|
    t.integer  "question_id"
    t.integer  "user_id"
    t.string   "answer_content"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "questionnaires", force: true do |t|
    t.integer  "user_id"
    t.string   "qa_title"
    t.string   "qa_subject"
    t.string   "qa_description"
    t.integer  "qa_is_anonymous"
    t.integer  "qa_ip_limit"
    t.integer  "qa_status"
    t.string   "qa_special_list"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "qa_user_limit"
  end

  create_table "questions", force: true do |t|
    t.integer  "questionnaire_id"
    t.integer  "q_type"
    t.string   "q_content"
    t.string   "q_choice"
    t.integer  "q_index"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "relations", force: true do |t|
    t.integer  "user_id"
    t.integer  "questionnaire_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "user_name"
    t.string   "user_email"
    t.integer  "user_age"
    t.string   "user_sex"
    t.integer  "user_status"
    t.integer  "user_is_admin"
    t.string   "user_job"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "remember_token"
    t.string   "password_digest"
  end

  add_index "users", ["remember_token"], name: "index_users_on_remember_token"

end
