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

ActiveRecord::Schema.define(version: 20210605192229) do

  create_table "answers", force: :cascade do |t|
    t.date "answer_on"
    t.float "quantity"
    t.string "note"
    t.integer "order_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["order_id"], name: "index_answers_on_order_id"
  end

  create_table "deliveries", force: :cascade do |t|
    t.date "delivery_on"
    t.float "quantity"
    t.string "lot_number"
    t.boolean "invoice", default: false
    t.integer "arrival_confirmer_id"
    t.integer "invoice_confirmer_id"
    t.integer "answer_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["answer_id"], name: "index_deliveries_on_answer_id"
  end

  create_table "departments", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "manufacturers", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "orders", force: :cascade do |t|
    t.date "order_on", default: "2022-01-02"
    t.float "quantity"
    t.date "desired_on"
    t.integer "paint_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "reaction", default: false
    t.index ["paint_id"], name: "index_orders_on_paint_id"
  end

  create_table "paints", force: :cascade do |t|
    t.string "name"
    t.integer "manufacturer_id"
    t.integer "supplier_id"
    t.float "unit_price"
    t.string "unit"
    t.float "ordering_point"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["manufacturer_id"], name: "index_paints_on_manufacturer_id"
    t.index ["supplier_id"], name: "index_paints_on_supplier_id"
  end

  create_table "suppliers", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "password_digest"
    t.string "remember_digest"
    t.boolean "admin", default: false
    t.integer "department_id"
    t.index ["department_id"], name: "index_users_on_department_id"
    t.index ["email"], name: "index_users_on_email", unique: true
  end

end
