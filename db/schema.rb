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

ActiveRecord::Schema.define(version: 20151130030926) do

  create_table "airlines", force: true do |t|
    t.string "code",       limit: 2,  null: false
    t.string "short_name", limit: 20, null: false
    t.string "name",       limit: 50
  end

  create_table "fares", force: true do |t|
    t.integer "route_id"
    t.string  "service_class", limit: 1
    t.string  "currency",      limit: 3
    t.integer "base_price"
  end

  create_table "flight_segments", force: true do |t|
    t.integer "airline_id"
    t.string  "number",             limit: 4
    t.string  "key",                limit: 6
    t.string  "origin",             limit: 3
    t.string  "destination",        limit: 3
    t.string  "departure_terminal", limit: 12
    t.string  "departure_time",     limit: 5
    t.string  "arrival_terminal",   limit: 12
    t.string  "arrival_time",       limit: 5
    t.integer "arrival_date_delta",            default: 0
    t.string  "aircraft",           limit: 3
  end

  create_table "flight_segments_routes", force: true do |t|
    t.integer "flight_segment_id"
    t.integer "route_id"
  end

  create_table "routes", force: true do |t|
    t.integer "airline_id"
    t.string  "origin",         limit: 3
    t.string  "destination",    limit: 3
    t.string  "departure_time", limit: 5
  end

end
