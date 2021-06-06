class AddNameLevelEquipmentToWorkoutPlans < ActiveRecord::Migration[6.1]
  def change
    add_column :workout_plans, :name, :string, :null => false
    add_column :workout_plans, :level, :integer, :default => 0
    add_column :workout_plans, :requires_equipment, :boolean, :default => false
  end
end
