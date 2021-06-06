class AddSetsRepsDurationToClientsExerciseInstance < ActiveRecord::Migration[6.1]
  def change
    add_column :clients_exercise_instances, :sets, :integer
    add_column :clients_exercise_instances, :reps, :integer
    add_column :clients_exercise_instances, :duration, :integer
  end
end
