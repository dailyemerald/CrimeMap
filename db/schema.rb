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

ActiveRecord::Schema.define(:version => 20121106195000) do

  create_table "incidents", :force => true do |t|
    t.string   "police_response_raw"
    t.string   "incident_description"
    t.string   "ofc"
    t.string   "received_raw"
    t.string   "disp"
    t.string   "location_raw"
    t.string   "event_number"
    t.string   "cad_id"
    t.string   "priority_raw"
    t.string   "case_number"
    t.integer  "priority"
    t.datetime "police_response"
    t.datetime "received"
    t.string   "location"
    t.datetime "created_at",           :null => false
    t.datetime "updated_at",           :null => false
    t.float    "latitude"
    t.float    "longitude"
  end

end
