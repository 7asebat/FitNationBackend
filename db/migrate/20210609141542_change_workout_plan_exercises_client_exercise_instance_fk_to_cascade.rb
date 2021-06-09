class ChangeWorkoutPlanExercisesClientExerciseInstanceFkToCascade < ActiveRecord::Migration[6.1]
  def change
    remove_foreign_key :clients_exercise_instances, :workout_plan_exercises, column: :workout_plan_exercise_id
    add_foreign_key :clients_exercise_instances, :workout_plan_exercises, column: :workout_plan_exercise_id, on_delete: :nullify
  end
end
