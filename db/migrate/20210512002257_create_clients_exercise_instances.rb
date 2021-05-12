class CreateClientsExerciseInstances < ActiveRecord::Migration[6.1]
  def change
    create_table :clients_exercise_instances do |t|
      t.references :client, null: false, foreign_key: true
      t.datetime :date
      t.references :workout_plan_exercise, null: false, foreign_key: true
      t.integer :performance

      t.timestamps
    end
  end
end
