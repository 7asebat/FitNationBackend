class AddActiveWorkoutPlanToClients < ActiveRecord::Migration[6.1]
  def change
    add_reference :clients, :workout_plans, foreign_key: true 
  end
end
