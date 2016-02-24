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
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20160224131149) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "uuid-ossp"

  create_table "escorts", id: :uuid, default: "uuid_generate_v4()", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "prisoners", id: :uuid, default: "uuid_generate_v4()", force: :cascade do |t|
    t.uuid     "escort_id"
    t.string   "family_name"
    t.string   "forenames"
    t.date     "date_of_birth"
    t.string   "sex"
    t.string   "prison_number"
    t.string   "nationality"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.string   "cro_number"
    t.string   "pnc_number"
  end

  create_table "risk_information", id: :uuid, default: "uuid_generate_v4()", force: :cascade do |t|
    t.uuid     "escort_id"
    t.boolean  "to_self"
    t.text     "to_self_details"
    t.boolean  "to_others"
    t.text     "to_others_details"
    t.boolean  "violence"
    t.text     "violence_details"
    t.boolean  "from_others"
    t.text     "from_others_details"
    t.boolean  "escape"
    t.text     "escape_details"
    t.boolean  "intolerant_behaviour"
    t.text     "intolerant_behaviour_details"
    t.boolean  "prohibited_items"
    t.text     "prohibited_items_details"
    t.boolean  "disabilities"
    t.text     "disabilities_details"
    t.boolean  "allergies"
    t.text     "allergies_details"
    t.boolean  "non_association"
    t.text     "non_association_details"
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
  end

  create_table "versions", force: :cascade do |t|
    t.string   "item_type",      null: false
    t.string   "event",          null: false
    t.string   "whodunnit"
    t.jsonb    "object"
    t.jsonb    "object_changes"
    t.datetime "created_at"
    t.uuid     "item_id",        null: false
  end

end
