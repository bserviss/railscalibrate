# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20100313131807) do

  create_table "calibrators", :force => true do |t|
    t.string   "a_name"
    t.string   "address_line_1"
    t.string   "address_line_2"
    t.string   "city"
    t.string   "state"
    t.string   "zip"
    t.string   "note"
    t.integer  "event_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "dependents", :force => true do |t|
    t.integer  "item_id"
    t.string   "pn"
    t.string   "model"
    t.string   "note"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "events", :force => true do |t|
    t.integer  "item_id"
    t.datetime "cal_date"
    t.integer  "calibrator_id"
    t.decimal  "cost"
    t.string   "po"
    t.string   "certs_file_name"
    t.string   "certs_content_type"
    t.integer  "certs_file_size"
    t.datetime "certs_updated_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "issues", :force => true do |t|
    t.integer  "item_id"
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "items", :force => true do |t|
    t.string   "description"
    t.string   "mfgr"
    t.string   "pn"
    t.string   "org_sn"
    t.string   "mfgr_sn"
    t.string   "location"
    t.integer  "cal_cycle_days",       :default => 365
    t.date     "last_calibrated_on"
    t.boolean  "inCal",                :default => false
    t.integer  "inactive",             :default => 0
    t.string   "picture_file_name"
    t.string   "picture_content_type"
    t.integer  "picture_file_size"
    t.datetime "picture_updated_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
