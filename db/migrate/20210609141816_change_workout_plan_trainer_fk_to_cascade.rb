class ChangeWorkoutPlanTrainerFkToCascade < ActiveRecord::Migration[6.1]
  def change
    remove_foreign_key :workout_plans, :trainers, column: :trainer_id
    add_foreign_key :workout_plans, :trainers, column: :trainer_id, on_delete: :cascade
  end
end
