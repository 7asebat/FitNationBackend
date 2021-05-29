class ChangeWorkoutPlanTrainerIdToNullable < ActiveRecord::Migration[6.1]
  def change
    change_column_null :workout_plans, :trainer_id, true
  end
end
