class ChangeWorkoutPlanExerciseToNullableInClientsExerciseInstance < ActiveRecord::Migration[6.1]
  def change
    change_column_null :clients_exercise_instances, :workout_plan_exercise_id, true
    change_column_null :clients_exercise_instances, :exercise_id, true
  end
end
