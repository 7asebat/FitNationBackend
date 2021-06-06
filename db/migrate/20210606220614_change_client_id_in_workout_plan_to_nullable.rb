class ChangeClientIdInWorkoutPlanToNullable < ActiveRecord::Migration[6.1]
  def change
    change_column_null :workout_plans, :client_id, true
  end
end
