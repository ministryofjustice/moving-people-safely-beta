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

ActiveRecord::Schema.define(version: 20160412134925) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "uuid-ossp"

  create_table "escorts", id: :uuid, default: "uuid_generate_v4()", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "healthcare", id: :uuid, default: "uuid_generate_v4()", force: :cascade do |t|
    t.uuid     "escort_id"
    t.boolean  "physical_risk"
    t.text     "physical_risk_details"
    t.boolean  "mental_risk"
    t.text     "mental_risk_details"
    t.boolean  "social_care_and_other"
    t.text     "social_care_and_other_details"
    t.boolean  "allergies"
    t.text     "allergies_details"
    t.boolean  "disabilities"
    t.boolean  "mpv_required"
    t.text     "disabilities_details"
    t.boolean  "medication"
    t.string   "medical_professional_name"
    t.string   "contact_telephone"
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
  end

  create_table "medications", id: :uuid, default: "uuid_generate_v4()", force: :cascade do |t|
    t.uuid     "healthcare_id"
    t.text     "description"
    t.text     "administration"
    t.string   "carrier"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  create_table "moves", id: :uuid, default: "uuid_generate_v4()", force: :cascade do |t|
    t.uuid     "escort_id"
    t.string   "origin"
    t.string   "destination"
    t.date     "date_of_travel"
    t.string   "reason"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  create_table "offences", id: :uuid, default: "uuid_generate_v4()", force: :cascade do |t|
    t.uuid     "escort_id"
    t.boolean  "not_for_release"
    t.text     "not_for_release_details"
    t.boolean  "must_return"
    t.text     "must_return_details"
    t.boolean  "must_not_return"
    t.text     "must_not_return_details"
    t.boolean  "other_offences"
    t.text     "other_offences_details"
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
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

  create_table "risks", id: :uuid, default: "uuid_generate_v4()", force: :cascade do |t|
    t.uuid     "escort_id"
    t.boolean  "to_self"
    t.text     "to_self_details"
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
    t.boolean  "non_association"
    t.text     "non_association_details"
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
    t.boolean  "open_acct"
  end

  create_table "users", force: :cascade do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "job_role"
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "invitation_token"
    t.datetime "invitation_created_at"
    t.datetime "invitation_sent_at"
    t.datetime "invitation_accepted_at"
    t.integer  "invitation_limit"
    t.integer  "invited_by_id"
    t.string   "invited_by_type"
    t.integer  "invitations_count",      default: 0
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["invitation_token"], name: "index_users_on_invitation_token", unique: true, using: :btree
  add_index "users", ["invitations_count"], name: "index_users_on_invitations_count", using: :btree
  add_index "users", ["invited_by_id"], name: "index_users_on_invited_by_id", using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

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
