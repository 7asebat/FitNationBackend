class AddExerciseIdToClientsExerciseInstance < ActiveRecord::Migration[6.1]
  def change
    add_column :clients_exercise_instances, :exercise_id, :int
    add_foreign_key :clients_exercise_instances, :exercises
  end
end
