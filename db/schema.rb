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

ActiveRecord::Schema.define(version: 20170609160145) do

  create_table "statistics", force: :cascade do |t|
    t.integer "user_count"
    t.integer "subber_id"
    t.integer "date"
    t.string "data_title"
  end

  create_table "subbers", force: :cascade do |t|
    t.string "server_name"
    t.string "server_location"
    t.string "server_alias"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "key"
  end

end
