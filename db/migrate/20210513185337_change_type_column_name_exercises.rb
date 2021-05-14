class ChangeTypeColumnNameExercises < ActiveRecord::Migration[6.1]
  def change
    rename_column :exercises, :type, :exercise_type
  end
end
