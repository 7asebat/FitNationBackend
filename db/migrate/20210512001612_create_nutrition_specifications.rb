class CreateNutritionSpecifications < ActiveRecord::Migration[6.1]
  def change
    create_table :nutrition_specifications do |t|
      t.references :food, null: false, foreign_key: true
      t.references :recipe, null: false, foreign_key: true
      t.integer :quantity

      t.timestamps
    end
  end
end
