class CreateFoods < ActiveRecord::Migration[6.1]
  def change
    create_table :foods do |t|
      t.boolean :has_image
      t.string :name
      t.integer :type
      t.json :nutrition_facts

      t.timestamps
    end
  end
end
