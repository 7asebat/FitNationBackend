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

ActiveRecord::Schema.define(version: 2021_05_12_000808) do

  create_table "admins", charset: "latin1", force: :cascade do |t|
    t.bigint "user_auth_id", null: false
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_auth_id"], name: "index_admins_on_user_auth_id"
  end

  create_table "clients", charset: "latin1", force: :cascade do |t|
    t.string "name"
    t.bigint "user_auth_id", null: false
    t.integer "country"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_auth_id"], name: "index_clients_on_user_auth_id"
  end

  create_table "exercises", charset: "latin1", force: :cascade do |t|
    t.string "name"
    t.text "tips"
    t.integer "type"
    t.json "meta_data"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "foods", charset: "latin1", force: :cascade do |t|
    t.boolean "has_image"
    t.string "name"
    t.integer "type"
    t.json "nutrition_facts"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "foods_recipes", id: false, charset: "latin1", force: :cascade do |t|
    t.bigint "recipe_id", null: false
    t.bigint "food_id", null: false
    t.index ["food_id"], name: "index_foods_recipes_on_food_id"
    t.index ["recipe_id"], name: "index_foods_recipes_on_recipe_id"
  end

  create_table "nutritionists", charset: "latin1", force: :cascade do |t|
    t.string "name"
    t.bigint "user_auth_id", null: false
    t.integer "country"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_auth_id"], name: "index_nutritionists_on_user_auth_id"
  end

  create_table "recipes", charset: "latin1", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.string "photo"
    t.bigint "nutritionist_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["nutritionist_id"], name: "index_recipes_on_nutritionist_id"
  end

  create_table "trainer_client_messages", charset: "latin1", force: :cascade do |t|
    t.bigint "client_id", null: false
    t.bigint "trainer_id", null: false
    t.string "body"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["client_id"], name: "index_trainer_client_messages_on_client_id"
    t.index ["trainer_id"], name: "index_trainer_client_messages_on_trainer_id"
  end

  create_table "trainers", charset: "latin1", force: :cascade do |t|
    t.string "name"
    t.bigint "user_auth_id", null: false
    t.integer "country"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_auth_id"], name: "index_trainers_on_user_auth_id"
  end

  create_table "user_auths", charset: "latin1", force: :cascade do |t|
    t.string "password_digest"
    t.integer "role"
    t.string "reset_password_token"
    t.datetime "reset_password_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "workout_plans", charset: "latin1", force: :cascade do |t|
    t.bigint "client_id", null: false
    t.bigint "trainer_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["client_id"], name: "index_workout_plans_on_client_id"
    t.index ["trainer_id"], name: "index_workout_plans_on_trainer_id"
  end

  add_foreign_key "admins", "user_auths"
  add_foreign_key "clients", "user_auths"
  add_foreign_key "nutritionists", "user_auths"
  add_foreign_key "recipes", "nutritionists"
  add_foreign_key "trainer_client_messages", "clients"
  add_foreign_key "trainer_client_messages", "trainers"
  add_foreign_key "trainers", "user_auths"
  add_foreign_key "workout_plans", "clients"
  add_foreign_key "workout_plans", "trainers"
end
