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

ActiveRecord::Schema.define(version: 20160603005832) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "bodyweights", force: :cascade do |t|
    t.integer  "user_id"
    t.date     "bodyweight_recorded_date"
    t.integer  "bodyweight_recorded_kg"
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  add_index "bodyweights", ["user_id"], name: "index_bodyweights_on_user_id", using: :btree

  create_table "intakes", force: :cascade do |t|
    t.integer  "user_id"
    t.time     "logged_time"
    t.date     "logged_date"
    t.string   "consumed_item"
    t.integer  "consumed_qty"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.string   "ndbno"
  end

  add_index "intakes", ["user_id"], name: "index_intakes_on_user_id", using: :btree

  create_table "lipids", force: :cascade do |t|
    t.integer  "intake_id"
    t.decimal  "saturated_fatty_acids_g"
    t.decimal  "monounsaturated_fatty_acids_g"
    t.decimal  "polyunsaturated_fatty_acid_g"
    t.decimal  "trans_fatty_acid_g"
    t.decimal  "cholesterol_mg"
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
  end

  add_index "lipids", ["intake_id"], name: "index_lipids_on_intake_id", using: :btree

  create_table "minerals", force: :cascade do |t|
    t.integer  "intake_id"
    t.decimal  "calcium_mg"
    t.decimal  "iron_mg"
    t.decimal  "magnesium_mg"
    t.decimal  "phosphorus_mg"
    t.decimal  "potassium_mg"
    t.decimal  "sodium_mg"
    t.decimal  "zinc_mg"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  add_index "minerals", ["intake_id"], name: "index_minerals_on_intake_id", using: :btree

  create_table "others", force: :cascade do |t|
    t.integer  "intake_id"
    t.decimal  "caffine_mg"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "others", ["intake_id"], name: "index_others_on_intake_id", using: :btree

  create_table "proximates", force: :cascade do |t|
    t.integer  "intake_id"
    t.decimal  "water_g"
    t.decimal  "energy_kcal"
    t.decimal  "protein_g"
    t.decimal  "total_fat_g"
    t.decimal  "carbohydrate_g"
    t.decimal  "total_dietary_fibre_g"
    t.decimal  "total_sugar_g"
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
  end

  add_index "proximates", ["intake_id"], name: "index_proximates_on_intake_id", using: :btree

  create_table "users", force: :cascade do |t|
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
    t.string   "first_name"
    t.string   "last_name"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  create_table "vitamins", force: :cascade do |t|
    t.integer  "intake_id"
    t.decimal  "vitamin_c_mg"
    t.decimal  "thiamin_mg"
    t.decimal  "riboflavin_mg"
    t.decimal  "niacin_mg"
    t.decimal  "vitamin_b_6_mg"
    t.decimal  "folate_dfe_μg"
    t.decimal  "vitamin_b_12_μg"
    t.decimal  "vitamin_a_rae_μg"
    t.decimal  "vitamin_a_iu"
    t.decimal  "vitamin_e_mg"
    t.decimal  "vitamin_d_μg"
    t.decimal  "vitamin_d_iu"
    t.decimal  "vitamin_k_μg"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  add_index "vitamins", ["intake_id"], name: "index_vitamins_on_intake_id", using: :btree

  add_foreign_key "bodyweights", "users"
  add_foreign_key "intakes", "users"
  add_foreign_key "lipids", "intakes"
  add_foreign_key "minerals", "intakes"
  add_foreign_key "others", "intakes"
  add_foreign_key "proximates", "intakes"
  add_foreign_key "vitamins", "intakes"
end
