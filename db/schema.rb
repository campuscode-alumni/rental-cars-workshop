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

ActiveRecord::Schema.define(version: 2019_09_09_210307) do

  create_table "addresses", force: :cascade do |t|
    t.string "street"
    t.string "number"
    t.string "complement"
    t.string "neighborhood"
    t.string "city"
    t.string "state"
    t.integer "subsidiary_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["subsidiary_id"], name: "index_addresses_on_subsidiary_id"
  end

  create_table "car_models", force: :cascade do |t|
    t.string "name"
    t.string "year"
    t.integer "manufacture_id"
    t.text "car_options"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["manufacture_id"], name: "index_car_models_on_manufacture_id"
  end

  create_table "cars", force: :cascade do |t|
    t.integer "car_model_id"
    t.integer "car_km"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "license_plate"
    t.string "color"
    t.integer "subsidiary_id"
    t.integer "status", default: 0
    t.index ["car_model_id"], name: "index_cars_on_car_model_id"
    t.index ["subsidiary_id"], name: "index_cars_on_subsidiary_id"
  end

  create_table "customers", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "cpf"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "phone"
    t.string "type"
    t.string "cnpj"
    t.string "fantasy_name"
  end

  create_table "fines", force: :cascade do |t|
    t.date "issued_on"
    t.integer "demerit_points"
    t.float "fine_value"
    t.string "address"
    t.integer "car_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["car_id"], name: "index_fines_on_car_id"
  end

  create_table "inspections", force: :cascade do |t|
    t.integer "fuel_level"
    t.integer "cleanance_level"
    t.text "damages"
    t.integer "car_id"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["car_id"], name: "index_inspections_on_car_id"
    t.index ["user_id"], name: "index_inspections_on_user_id"
  end

  create_table "maintenances", force: :cascade do |t|
    t.integer "car_id"
    t.integer "provider_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "invoice"
    t.decimal "service_cost"
    t.index ["car_id"], name: "index_maintenances_on_car_id"
    t.index ["provider_id"], name: "index_maintenances_on_provider_id"
  end

  create_table "manufactures", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "providers", force: :cascade do |t|
    t.string "name"
    t.string "cnpj"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "rentals", force: :cascade do |t|
    t.integer "car_id"
    t.integer "user_id"
    t.integer "customer_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "start_at"
    t.datetime "finish_at"
    t.datetime "finished_at"
    t.integer "status", default: 0
    t.date "scheduled_start"
    t.date "scheduled_end"
    t.datetime "started_at"
    t.datetime "ended_at"
    t.index ["car_id"], name: "index_rentals_on_car_id"
    t.index ["customer_id"], name: "index_rentals_on_customer_id"
    t.index ["user_id"], name: "index_rentals_on_user_id"
  end

  create_table "subsidiaries", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "subsidiary_car_models", force: :cascade do |t|
    t.decimal "price"
    t.integer "subsidiary_id"
    t.integer "car_model_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["car_model_id"], name: "index_subsidiary_car_models_on_car_model_id"
    t.index ["subsidiary_id"], name: "index_subsidiary_car_models_on_subsidiary_id"
  end

  create_table "transactions", force: :cascade do |t|
    t.decimal "amount"
    t.string "type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "subsidiary_id"
    t.string "transactable_type"
    t.integer "transactable_id"
    t.index ["subsidiary_id"], name: "index_transactions_on_subsidiary_id"
    t.index ["transactable_type", "transactable_id"], name: "index_transactions_on_transactable_type_and_transactable_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "subsidiary_id"
    t.integer "role", default: 0
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["subsidiary_id"], name: "index_users_on_subsidiary_id"
  end

end
