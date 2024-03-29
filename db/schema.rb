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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20121217212956) do

  create_table "answers", :force => true do |t|
    t.integer  "user_id"
    t.integer  "question_id"
    t.text     "text"
    t.integer  "category"
    t.boolean  "deleted"
    t.text     "aupvotesfrom"
    t.integer  "aupvotesfromcount"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "comments", :force => true do |t|
    t.integer  "user_id"
    t.integer  "answer_id"
    t.integer  "question_id"
    t.text     "text"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "questions", :force => true do |t|
    t.integer  "user_id"
    t.text     "text"
    t.boolean  "deleted"
    t.string   "tags"
    t.integer  "qcat"
    t.text     "qupvotesfrom"
    t.integer  "qupvotesfromcount"
    t.integer  "answercount"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "name"
    t.string   "email"
    t.string   "password"
    t.string   "encrypted_password"
    t.boolean  "admin"
    t.boolean  "banned"
    t.text     "upvotesfrom"
    t.text     "upvotesto"
    t.text     "qupvotesto"
    t.text     "aupvotesto"
    t.string   "salt"
    t.string   "location"
    t.text     "background"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
