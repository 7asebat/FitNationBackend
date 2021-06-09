class ChangeExerciseClientExerciseInstanceFkToCascade < ActiveRecord::Migration[6.1]
  def change
    remove_foreign_key :clients_exercise_instances, :exercises, column: :exercise_id
    add_foreign_key :clients_exercise_instances, :exercises, column: :exercise_id, on_delete: :cascade
  end
end
