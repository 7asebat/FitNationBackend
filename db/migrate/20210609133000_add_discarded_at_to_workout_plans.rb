class AddDiscardedAtToWorkoutPlans < ActiveRecord::Migration[6.1]
  def change
    add_column :workout_plans, :discarded_at, :datetime
    add_index :workout_plans, :discarded_at
  end
end
