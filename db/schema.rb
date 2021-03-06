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

ActiveRecord::Schema.define(:version => 20130306024413) do

  create_table "comments", :force => true do |t|
    t.string  "email",              :default => "", :null => false
    t.integer "refactored_code_id", :default => 0,  :null => false
    t.string  "comment"
  end

  create_table "refactored_codes", :force => true do |t|
    t.string  "email",           :default => "", :null => false
    t.text    "refactored_code"
    t.boolean "anonymous"
    t.string  "language"
  end

  create_table "votes", :force => true do |t|
    t.string  "email",              :default => "", :null => false
    t.integer "refactored_code_id"
    t.integer "num"
  end

end
