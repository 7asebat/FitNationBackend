class ChangeClientsActiveWorkoutPlanFkToCascade < ActiveRecord::Migration[6.1]
  def change
    remove_foreign_key :clients, :workout_plans, column: :active_workout_plan_id
    add_foreign_key :clients, :workout_plans, column: :active_workout_plan_id, on_delete: :nullify
  end
end
