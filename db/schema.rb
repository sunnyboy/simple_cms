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

ActiveRecord::Schema.define(:version => 20101228091633) do

  create_table "admin_users", :force => true do |t|
    t.string   "first_name",      :limit => 25
    t.string   "last_name",       :limit => 50
    t.string   "email",           :limit => 100, :default => "", :null => false
    t.string   "hashed_password", :limit => 40
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "username",        :limit => 25
    t.string   "salt",            :limit => 40
  end

  add_index "admin_users", ["username"], :name => "index_admin_users_on_username"

  create_table "admin_users_pages", :id => false, :force => true do |t|
    t.integer "admin_user_id"
    t.integer "page_id"
  end

  add_index "admin_users_pages", ["admin_user_id", "page_id"], :name => "index_admin_users_pages_on_admin_user_id_and_page_id"

  create_table "documents", :force => true do |t|
    t.integer  "id_group"
    t.integer  "id_company"
    t.integer  "id_sender"
    t.integer  "id_recipient"
    t.integer  "id_payer"
    t.integer  "id_beneficiary"
    t.integer  "id_project"
    t.integer  "id_doctype"
    t.string   "filepath"
    t.string   "filename"
    t.string   "filename_original"
    t.string   "db_link"
    t.integer  "size"
    t.string   "localpath"
    t.time     "doctime"
    t.date     "docdate"
    t.date     "docdate_paid"
    t.date     "doctade_delivered"
    t.float    "ammount_brutto"
    t.float    "ammount_netto"
    t.float    "ammount_vat"
    t.string   "ammount_currency"
    t.string   "bookedunder"
    t.string   "content"
    t.string   "notepublic"
    t.string   "noteprivat"
    t.string   "reference"
    t.string   "flags"
    t.integer  "selected"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "booking"
  end

  create_table "pages", :force => true do |t|
    t.integer  "story_id"
    t.string   "name"
    t.string   "permalink"
    t.integer  "position"
    t.boolean  "visible",    :default => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "pages", ["permalink"], :name => "index_pages_on_permalink"
  add_index "pages", ["story_id"], :name => "index_pages_on_story_id"

  create_table "section_edits", :force => true do |t|
    t.integer  "admin_user_id"
    t.integer  "section_id"
    t.string   "summary"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "section_edits", ["admin_user_id", "section_id"], :name => "index_section_edits_on_admin_user_id_and_section_id"

  create_table "sections", :force => true do |t|
    t.integer  "page_id"
    t.string   "name"
    t.integer  "position"
    t.boolean  "visible",        :default => false
    t.string   "content_type"
    t.text     "content"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "published_from"
    t.datetime "published_to"
  end

  add_index "sections", ["page_id"], :name => "index_sections_on_page_id"

  create_table "stories", :force => true do |t|
    t.string   "name"
    t.integer  "position"
    t.boolean  "visible",    :default => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
