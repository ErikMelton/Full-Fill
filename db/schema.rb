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

ActiveRecord::Schema.define(version: 20161122230831) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "activities", force: :cascade do |t|
    t.string   "activityname"
    t.string   "activity_desc"
    t.integer  "trait_id"
    t.string   "activity_note"
    t.integer  "activity_spec_id"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  create_table "clients", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
  end

  add_index "clients", ["email"], name: "index_clients_on_email", unique: true, using: :btree
  add_index "clients", ["reset_password_token"], name: "index_clients_on_reset_password_token", unique: true, using: :btree

  create_table "events", force: :cascade do |t|
    t.integer  "person_id"
    t.integer  "activity_hours"
    t.integer  "activity_id"
    t.string   "activity_note"
    t.string   "activity_place"
    t.string   "activity_when"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.string   "activityname"
  end

  create_table "facets", force: :cascade do |t|
    t.string   "facettype"
    t.string   "facet_long"
    t.string   "facet_desc"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "people", force: :cascade do |t|
    t.integer  "client_id"
    t.string   "name_first"
    t.string   "name_middle"
    t.string   "name_last"
    t.string   "name_nick"
    t.string   "name_prefix"
    t.string   "name_suffix"
    t.string   "birth_date"
    t.integer  "physical_score"
    t.integer  "social_score"
    t.integer  "abstract_score"
    t.integer  "creative_score"
    t.integer  "expressive_score"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  create_table "traits", force: :cascade do |t|
    t.string   "traitname"
    t.string   "trait_desc"
    t.integer  "facet_id"
    t.integer  "trait_spec_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

end
