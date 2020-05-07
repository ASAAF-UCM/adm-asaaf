# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_05_06_110749) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "pgcrypto"
  enable_extension "plpgsql"

  create_table "id_document_types", force: :cascade do |t|
    t.string "name", null: false
  end

  create_table "member_types", force: :cascade do |t|
    t.string "name", null: false
  end

  create_table "members", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name", null: false
    t.string "surname1", null: false
    t.string "surname2"
    t.date "birthdate", null: false
    t.integer "id_document_type_id", null: false
    t.date "id_document_expiration_date", null: false
    t.string "id_document_number", null: false
    t.jsonb "image_data"
    t.integer "member_number"
    t.integer "member_type_id"
    t.date "member_since"
    t.date "last_active_member_confirmation"
    t.string "moodle_name"
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.integer "failed_attempts", default: 0, null: false
    t.string "unlock_token"
    t.datetime "locked_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["confirmation_token"], name: "index_members_on_confirmation_token", unique: true
    t.index ["email"], name: "index_members_on_email", unique: true
    t.index ["id_document_number"], name: "index_members_on_id_document_number"
    t.index ["member_number"], name: "index_members_on_member_number"
    t.index ["reset_password_token"], name: "index_members_on_reset_password_token", unique: true
    t.index ["unlock_token"], name: "index_members_on_unlock_token", unique: true
  end

  create_table "role_allocations", force: :cascade do |t|
    t.bigint "role_type_id", null: false
    t.uuid "member_id", null: false
    t.boolean "is_active"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["member_id"], name: "index_role_allocations_on_member_id"
    t.index ["role_type_id"], name: "index_role_allocations_on_role_type_id"
  end

  create_table "role_types", force: :cascade do |t|
    t.string "role_name"
  end

  add_foreign_key "members", "id_document_types"
  add_foreign_key "members", "member_types"
  add_foreign_key "role_allocations", "members"
  add_foreign_key "role_allocations", "role_types"
end
