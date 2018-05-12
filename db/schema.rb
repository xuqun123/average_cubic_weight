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

ActiveRecord::Schema.define(version: 2018_05_12_190620) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "api_calculations", force: :cascade do |t|
    t.boolean "finished", default: false, null: false
    t.datetime "start_time"
    t.datetime "end_time"
    t.integer "duration"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "endpoint"
    t.integer "conversion_factor"
    t.decimal "average_cubic_weight", precision: 10, scale: 5
    t.string "category"
    t.index ["endpoint"], name: "index_api_calculations_on_endpoint"
    t.index ["finished"], name: "index_api_calculations_on_finished"
  end

  create_table "api_request_logs", force: :cascade do |t|
    t.string "endpoint"
    t.text "response"
    t.datetime "requested_time"
    t.string "request_errors"
    t.integer "api_calculation_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["api_calculation_id"], name: "index_api_request_logs_on_api_calculation_id"
  end

  create_table "products", force: :cascade do |t|
    t.string "category"
    t.string "title"
    t.decimal "length", precision: 10, scale: 6, default: "0.0"
    t.decimal "width", precision: 10, scale: 6, default: "0.0"
    t.decimal "height", precision: 10, scale: 6, default: "0.0"
    t.decimal "volume", precision: 10, scale: 6
    t.decimal "cubic_weight", precision: 10, scale: 5
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.decimal "weight", precision: 10, scale: 5, default: "0.0"
    t.index ["category"], name: "index_products_on_category"
  end

end
