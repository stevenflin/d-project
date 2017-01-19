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

ActiveRecord::Schema.define(version: 20170119014648) do

  create_table "agencies", force: :cascade do |t|
    t.string   "name"
    t.text     "description"
    t.integer  "user_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["user_id"], name: "index_agencies_on_user_id"
  end

  create_table "agencies_creators", id: false, force: :cascade do |t|
    t.integer "agency_id",  null: false
    t.integer "creator_id", null: false
    t.index ["agency_id", "creator_id"], name: "index_agencies_creators_on_agency_id_and_creator_id"
    t.index ["creator_id", "agency_id"], name: "index_agencies_creators_on_creator_id_and_agency_id"
  end

  create_table "brands", force: :cascade do |t|
    t.string   "name"
    t.text     "description"
    t.integer  "user_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["user_id"], name: "index_brands_on_user_id"
  end

  create_table "brands_creators", id: false, force: :cascade do |t|
    t.integer "brand_id",   null: false
    t.integer "creator_id", null: false
    t.index ["brand_id", "creator_id"], name: "index_brands_creators_on_brand_id_and_creator_id"
    t.index ["creator_id", "brand_id"], name: "index_brands_creators_on_creator_id_and_brand_id"
  end

  create_table "creators", force: :cascade do |t|
    t.string   "name"
    t.string   "propic"
    t.string   "link"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_creators_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.string   "kind"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
