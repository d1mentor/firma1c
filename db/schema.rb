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

ActiveRecord::Schema[7.0].define(version: 2022_07_16_185914) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "audits", force: :cascade do |t|
    t.integer "auditable_id"
    t.string "auditable_type"
    t.integer "associated_id"
    t.string "associated_type"
    t.integer "user_id"
    t.string "user_type"
    t.string "username"
    t.string "action"
    t.jsonb "audited_changes"
    t.integer "version", default: 0
    t.string "comment"
    t.string "remote_address"
    t.string "request_uuid"
    t.datetime "created_at"
    t.index ["associated_type", "associated_id"], name: "associated_index"
    t.index ["auditable_type", "auditable_id", "version"], name: "auditable_index"
    t.index ["created_at"], name: "index_audits_on_created_at"
    t.index ["request_uuid"], name: "index_audits_on_request_uuid"
    t.index ["user_id", "user_type"], name: "user_index"
  end

  create_table "customers", force: :cascade do |t|
    t.string "name", default: "", null: false
    t.string "position", default: "", null: false
    t.string "company", default: "", null: false
    t.string "description", default: "", null: false
    t.string "phone", default: "", null: false
    t.string "email", default: "", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "diaries", force: :cascade do |t|
    t.integer "worker_id", null: false
    t.integer "work_id", null: false
    t.float "completed_work_size"
    t.date "date", null: false
    t.string "description", default: "", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "hours"
    t.integer "user_id"
    t.boolean "verified"
    t.integer "admin_id"
  end

  create_table "galleries", force: :cascade do |t|
    t.string "name"
    t.string "galleryable_type"
    t.bigint "galleryable_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "images", default: [], array: true
    t.index ["galleryable_type", "galleryable_id"], name: "index_galleries_on_galleryable"
  end

  create_table "instruments", force: :cascade do |t|
    t.string "name", null: false
    t.string "description"
    t.integer "location_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.json "images"
  end

  create_table "locations", force: :cascade do |t|
    t.string "name", default: "", null: false
    t.string "adress", default: "", null: false
    t.string "description", default: "", null: false
    t.boolean "flag", default: true, null: false
    t.string "photos_url", default: "", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.json "images"
  end

  create_table "materials", force: :cascade do |t|
    t.string "name", default: "", null: false
    t.float "count", null: false
    t.string "dimension", default: "", null: false
    t.integer "supply_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "payments", force: :cascade do |t|
    t.date "date"
    t.float "size", null: false
    t.string "description"
    t.string "source_type"
    t.bigint "source_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "capital", default: false
    t.index ["source_type", "source_id"], name: "index_payments_on_source"
  end

  create_table "suppliers", force: :cascade do |t|
    t.string "name", default: "", null: false
    t.string "phone", default: "", null: false
    t.string "email", default: "", null: false
    t.string "description", default: "", null: false
    t.string "company", default: "", null: false
    t.string "position", default: "", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "supplies", force: :cascade do |t|
    t.integer "supplier_id"
    t.integer "location_id", null: false
    t.string "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.date "date"
  end

  create_table "transports", force: :cascade do |t|
    t.string "name", null: false
    t.date "to_date"
    t.date "insurance_date"
    t.string "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.json "images"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "admin"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "workers", force: :cascade do |t|
    t.string "name", default: "", null: false
    t.string "position", default: "", null: false
    t.string "company", default: "", null: false
    t.string "description", default: "", null: false
    t.string "phone", default: "", null: false
    t.string "email", default: "", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "works", force: :cascade do |t|
    t.string "name", default: "", null: false
    t.string "dimension", default: ""
    t.integer "size"
    t.boolean "flag", default: true, null: false
    t.integer "location_id"
    t.integer "customer_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.float "accord_price"
    t.float "hour_price"
  end

end
