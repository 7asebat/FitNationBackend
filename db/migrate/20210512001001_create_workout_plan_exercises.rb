class CreateWorkoutPlanExercises < ActiveRecord::Migration[6.1]
  def change
    create_table :workout_plan_exercises do |t|
      t.references :exercise, null: false, foreign_key: true
      t.references :workout_plan, null: false, foreign_key: true
      t.integer :day
      t.integer :order
      t.integer :duration
      t.integer :sets
      t.integer :reps

      t.timestamps
    end
  end
end
