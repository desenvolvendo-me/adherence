# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[8.0].define(version: 2024_12_02_170847) do
  create_table "blogs", force: :cascade do |t|
    t.string "title"
    t.string "body"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "published_at"
  end

  create_table "machine_products", force: :cascade do |t|
    t.integer "machine_id", null: false
    t.integer "product_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["machine_id", "product_id"], name: "index_machine_products_on_machine_id_and_product_id", unique: true
    t.index ["machine_id"], name: "index_machine_products_on_machine_id"
    t.index ["product_id"], name: "index_machine_products_on_product_id"
  end

  create_table "machines", force: :cascade do |t|
    t.string "code", null: false
    t.string "name", null: false
    t.integer "status", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["code"], name: "index_machines_on_code", unique: true
  end

  create_table "production_planning_items", force: :cascade do |t|
    t.integer "production_planning_id", null: false
    t.integer "machine_id", null: false
    t.integer "product_id", null: false
    t.integer "goal", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["machine_id"], name: "index_production_planning_items_on_machine_id"
    t.index ["product_id"], name: "index_production_planning_items_on_product_id"
    t.index ["production_planning_id"], name: "index_production_planning_items_on_production_planning_id"
  end

  create_table "production_plannings", force: :cascade do |t|
    t.date "planning_date", null: false
    t.string "shift", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["planning_date", "shift"], name: "index_production_plannings_on_planning_date_and_shift", unique: true
  end

  create_table "products", force: :cascade do |t|
    t.string "code", null: false
    t.string "name", null: false
    t.decimal "standard_time", precision: 10, scale: 2, null: false
    t.decimal "setup_time", precision: 10, scale: 2, null: false
    t.string "status", default: "active", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["code"], name: "index_products_on_code", unique: true
  end

  add_foreign_key "machine_products", "machines"
  add_foreign_key "machine_products", "products"
  add_foreign_key "production_planning_items", "machines"
  add_foreign_key "production_planning_items", "production_plannings"
  add_foreign_key "production_planning_items", "products"
end
