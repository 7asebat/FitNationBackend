class ChangeWorkoutPlanExercisesExercisesFkToCascade < ActiveRecord::Migration[6.1]
  def change
    remove_foreign_key :workout_plan_exercises, :exercises, column: :exercise_id
    add_foreign_key :workout_plan_exercises, :exercises, column: :exercise_id, on_delete: :cascade
  end
end
