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

ActiveRecord::Schema.define(version: 20160222115032) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "hstore"

  create_table "airlines", force: true do |t|
    t.string "code",       limit: 2,  null: false
    t.string "short_name", limit: 20, null: false
    t.string "name",       limit: 50
  end

  create_table "bundles", force: true do |t|
    t.string  "name"
    t.string  "bundle_id"
    t.integer "maximum_quantity"
  end

  create_table "bundles_fares", force: true do |t|
    t.integer "fare_id"
    t.integer "bundle_id"
  end

  create_table "bundles_routes", force: true do |t|
    t.integer "route_id"
    t.integer "bundle_id"
  end

  create_table "bundles_services", force: true do |t|
    t.integer "bundle_id"
    t.integer "service_id"
  end

  create_table "fares", force: true do |t|
    t.integer "route_id"
    t.string  "service_class",       limit: 1
    t.string  "currency",            limit: 3
    t.integer "base_price"
    t.integer "range_days_increase"
    t.float   "rate_increase"
    t.float   "taxes_applicable"
  end

  create_table "flight_segments", force: true do |t|
    t.integer "airline_id"
    t.string  "number",                 limit: 4
    t.string  "key",                    limit: 6
    t.string  "departure_airport_code", limit: 3
    t.string  "departure_airport_name"
    t.string  "departure_terminal",     limit: 3
    t.string  "departure_time",         limit: 5
    t.string  "arrival_airport_code",   limit: 3
    t.string  "arrival_airport_name"
    t.string  "arrival_terminal",       limit: 3
    t.string  "arrival_time",           limit: 5
    t.integer "duration"
    t.integer "distance"
    t.integer "distance_units"
    t.string  "aircraft",               limit: 3
    t.string  "marketing_carrier",      limit: 3
    t.string  "operating_carrier",      limit: 3
    t.integer "departure_mask",                   default: 127
    t.integer "arrival_mask",                     default: 127
  end

  create_table "flight_segments_routes", force: true do |t|
    t.integer "flight_segment_id"
    t.integer "route_id"
  end

  create_table "routes", force: true do |t|
    t.integer "airline_id"
    t.string  "origin",      limit: 3
    t.string  "destination", limit: 3
    t.hstore  "dow"
  end

  create_table "routes_services", force: true do |t|
    t.integer "route_id"
    t.integer "service_id"
  end

  create_table "services", force: true do |t|
    t.integer "airline_id"
    t.string  "name"
    t.string  "service_id"
    t.string  "owner"
    t.string  "description_text"
    t.string  "description_link"
    t.string  "description_object_id"
    t.string  "settlement_code"
    t.string  "settlement_definition"
    t.integer "price_total"
    t.string  "price_passanger_reference"
  end

end
