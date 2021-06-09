class ChangeWorkoutPlanExercisesWorkoutPlanFkToCascade < ActiveRecord::Migration[6.1]
  def change
    remove_foreign_key :workout_plan_exercises, :workout_plans, column: :workout_plan_id
    add_foreign_key :workout_plan_exercises, :workout_plans, column: :workout_plan_id, on_delete: :cascade
  end
end
