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

ActiveRecord::Schema.define(:version => 20120806140755) do

  create_table "calls", :force => true do |t|
    t.string   "to"
    t.string   "template"
    t.string   "sid"
    t.datetime "created_at",           :null => false
    t.datetime "updated_at",           :null => false
    t.string   "gathered_numbers"
    t.string   "recording_url"
    t.string   "recording_duration"
    t.string   "price"
    t.string   "status"
    t.string   "transcription_text"
    t.string   "transcription_status"
  end

  create_table "outgoing_caller_ids", :force => true do |t|
    t.string   "status"
    t.string   "validation_code"
    t.string   "sid"
    t.string   "phone_number"
    t.string   "friendly_name"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  create_table "sms", :force => true do |t|
    t.string   "direction"
    t.string   "text"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.string   "number"
  end

end
