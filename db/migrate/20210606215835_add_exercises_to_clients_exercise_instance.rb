class AddExercisesToClientsExerciseInstance < ActiveRecord::Migration[6.1]
  def change
    add_reference :clients_exercise_instances, :exercise, null: false, foreign_key: true
  end
end
