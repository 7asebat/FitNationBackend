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

ActiveRecord::Schema.define(version: 2021_06_06_220614) do

  create_table "active_storage_attachments", charset: "latin1", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", charset: "latin1", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", charset: "latin1", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

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

  create_table "clients_exercise_instances", charset: "latin1", force: :cascade do |t|
    t.bigint "client_id", null: false
    t.datetime "date"
    t.bigint "workout_plan_exercise_id", null: false
    t.integer "performance"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "exercise_id", null: false
    t.index ["client_id"], name: "index_clients_exercise_instances_on_client_id"
    t.index ["exercise_id"], name: "index_clients_exercise_instances_on_exercise_id"
    t.index ["workout_plan_exercise_id"], name: "index_clients_exercise_instances_on_workout_plan_exercise_id"
  end

  create_table "clients_weights_nutritions", charset: "latin1", force: :cascade do |t|
    t.bigint "client_id", null: false
    t.datetime "date"
    t.integer "weight"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["client_id"], name: "index_clients_weights_nutritions_on_client_id"
  end

  create_table "clients_weights_nutritions_nutrition_specifications", id: false, charset: "latin1", force: :cascade do |t|
    t.bigint "clients_weights_nutrition_id", null: false
    t.bigint "nutrition_specification_id", null: false
    t.index ["clients_weights_nutrition_id", "nutrition_specification_id"], name: "index_client_weights_nutrition_nutrition_specs"
    t.index ["nutrition_specification_id", "clients_weights_nutrition_id"], name: "index_nutrition_specs_client_weights_nutrition"
  end

  create_table "exercises", charset: "latin1", force: :cascade do |t|
    t.string "name"
    t.text "tips"
    t.integer "exercise_type"
    t.json "meta_data"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "foods", charset: "latin1", force: :cascade do |t|
    t.boolean "has_image"
    t.string "name"
    t.integer "food_type"
    t.json "nutrition_facts"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "foods_recipes", id: false, charset: "latin1", force: :cascade do |t|
    t.bigint "recipe_id", null: false
    t.bigint "food_id", null: false
    t.index ["food_id"], name: "index_foods_recipes_on_food_id"
    t.index ["recipe_id", "food_id"], name: "index_foods_recipes_on_recipe_id_and_food_id", unique: true
    t.index ["recipe_id"], name: "index_foods_recipes_on_recipe_id"
  end

  create_table "nutrition_specifications", charset: "latin1", force: :cascade do |t|
    t.bigint "food_id", null: false
    t.bigint "recipe_id", null: false
    t.integer "quantity"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["food_id"], name: "index_nutrition_specifications_on_food_id"
    t.index ["recipe_id"], name: "index_nutrition_specifications_on_recipe_id"
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
    t.string "email"
  end

  create_table "workout_plan_exercises", charset: "latin1", force: :cascade do |t|
    t.bigint "exercise_id", null: false
    t.bigint "workout_plan_id", null: false
    t.integer "day"
    t.integer "order"
    t.integer "duration"
    t.integer "sets"
    t.integer "reps"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["exercise_id"], name: "index_workout_plan_exercises_on_exercise_id"
    t.index ["workout_plan_id"], name: "index_workout_plan_exercises_on_workout_plan_id"
  end

  create_table "workout_plans", charset: "latin1", force: :cascade do |t|
    t.bigint "client_id"
    t.bigint "trainer_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "name", null: false
    t.integer "level", default: 0
    t.boolean "requires_equipment", default: false
    t.index ["client_id"], name: "index_workout_plans_on_client_id"
    t.index ["trainer_id"], name: "index_workout_plans_on_trainer_id"
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "admins", "user_auths"
  add_foreign_key "clients", "user_auths"
  add_foreign_key "clients_exercise_instances", "clients"
  add_foreign_key "clients_exercise_instances", "exercises"
  add_foreign_key "clients_exercise_instances", "workout_plan_exercises"
  add_foreign_key "clients_weights_nutritions", "clients"
  add_foreign_key "nutrition_specifications", "foods"
  add_foreign_key "nutrition_specifications", "recipes"
  add_foreign_key "nutritionists", "user_auths"
  add_foreign_key "recipes", "nutritionists"
  add_foreign_key "trainer_client_messages", "clients"
  add_foreign_key "trainer_client_messages", "trainers"
  add_foreign_key "trainers", "user_auths"
  add_foreign_key "workout_plan_exercises", "exercises"
  add_foreign_key "workout_plan_exercises", "workout_plans"
  add_foreign_key "workout_plans", "clients"
  add_foreign_key "workout_plans", "trainers"
end
