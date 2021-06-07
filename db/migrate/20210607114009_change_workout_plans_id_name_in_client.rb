class ChangeWorkoutPlansIdNameInClient < ActiveRecord::Migration[6.1]
  def change
    rename_column :clients, :workout_plans_id, :active_workout_plan_id
  end
end
