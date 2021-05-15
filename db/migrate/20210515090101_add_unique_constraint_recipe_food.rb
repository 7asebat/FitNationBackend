class AddUniqueConstraintRecipeFood < ActiveRecord::Migration[6.1]
  def change
    add_index :foods_recipes, [:recipe_id, :food_id], unique: true
  end
end
