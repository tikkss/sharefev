# -*- encoding : utf-8 -*-
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

ActiveRecord::Schema.define(:version => 20130601142242) do

  create_table "book_histories", :force => true do |t|
    t.integer  "book_id"
    t.integer  "year"
    t.string   "no",         :limit => 8
    t.string   "hit_text"
    t.datetime "created_at",              :null => false
  end

  add_index "book_histories", ["book_id"], :name => "index_book_histories_on_book_id"

  create_table "bookmarks", :force => true do |t|
    t.string   "name"
    t.string   "checked_url"
    t.string   "linked_url"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "books", :force => true do |t|
    t.string   "name",        :limit => 2
    t.string   "title",       :limit => 10
    t.string   "checked_url"
    t.string   "linked_url"
    t.datetime "created_at",                :null => false
    t.datetime "updated_at",                :null => false
  end

  create_table "rankings", :force => true do |t|
    t.integer  "timeline_id"
    t.string   "ip_address",  :limit => 32
    t.datetime "created_at",                :null => false
  end

  add_index "rankings", ["timeline_id"], :name => "index_rankings_on_timeline_id"

  create_table "timelines", :force => true do |t|
    t.integer  "book_history_id"
    t.integer  "bookmark_id"
    t.string   "hit_text"
    t.datetime "created_at",      :null => false
  end

  add_index "timelines", ["book_history_id", "bookmark_id"], :name => "index_timelines_on_book_history_id_and_bookmark_id"
  add_index "timelines", ["book_history_id"], :name => "index_timelines_on_book_history_id"
  add_index "timelines", ["bookmark_id"], :name => "index_timelines_on_bookmark_id"

end
