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

ActiveRecord::Schema.define(version: 20141018131257) do

  create_table "departments", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "ticket_statuses", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "default",    default: false
  end

  create_table "tickets", force: true do |t|
    t.integer  "customer_id"
    t.integer  "department_id"
    t.integer  "status_id"
    t.string   "subject"
    t.text     "body"
    t.integer  "staff_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "uid"
    t.string   "staff_type"
    t.string   "customer_type"
  end

  add_index "tickets", ["customer_id"], name: "index_tickets_on_customer_id", using: :btree
  add_index "tickets", ["department_id"], name: "index_tickets_on_department_id", using: :btree
  add_index "tickets", ["staff_id"], name: "index_tickets_on_staff_id", using: :btree
  add_index "tickets", ["status_id"], name: "index_tickets_on_status_id", using: :btree

  create_table "users", force: true do |t|
    t.string   "name"
    t.string   "email"
    t.string   "encrypted_password"
    t.integer  "department_id"
    t.string   "type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["department_id"], name: "index_users_on_department_id", using: :btree

  create_table "versions", force: true do |t|
    t.string   "item_type",      null: false
    t.integer  "item_id",        null: false
    t.string   "event",          null: false
    t.string   "whodunnit"
    t.text     "object"
    t.datetime "created_at"
    t.text     "object_changes"
  end

  add_index "versions", ["item_type", "item_id"], name: "index_versions_on_item_type_and_item_id", using: :btree

end
