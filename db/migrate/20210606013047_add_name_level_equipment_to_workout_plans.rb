class AddNameLevelEquipmentToWorkoutPlans < ActiveRecord::Migration[6.1]
  def change
    add_column :workout_plans, :name, :string
    add_column :workout_plans, :level, :integer
    add_column :workout_plans, :requires_equipment, :boolean
  end
end
