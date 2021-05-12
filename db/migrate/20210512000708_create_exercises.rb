class CreateExercises < ActiveRecord::Migration[6.1]
  def change
    create_table :exercises do |t|
      t.string :name
      t.text :tips
      t.integer :type
      t.json :meta_data

      t.timestamps
    end
  end
end
