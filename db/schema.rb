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

ActiveRecord::Schema.define(version: 20170908104528) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "balances", force: :cascade do |t|
    t.integer  "amount"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_balances_on_user_id", using: :btree
  end

  create_table "red_packet_records", force: :cascade do |t|
    t.integer  "amount"
    t.integer  "user_id"
    t.integer  "red_packet_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.index ["red_packet_id"], name: "index_red_packet_records_on_red_packet_id", using: :btree
    t.index ["user_id"], name: "index_red_packet_records_on_user_id", using: :btree
  end

  create_table "red_packets", force: :cascade do |t|
    t.string   "token",      limit: 8, null: false
    t.integer  "amount"
    t.integer  "quantity"
    t.boolean  "expired"
    t.integer  "user_id"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
    t.index ["token"], name: "index_red_packets_on_token", using: :btree
    t.index ["user_id"], name: "index_red_packets_on_user_id", using: :btree
  end

  create_table "users", force: :cascade do |t|
    t.string   "username"
    t.string   "password_digest"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

end
