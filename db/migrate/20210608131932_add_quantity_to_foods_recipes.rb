class AddQuantityToFoodsRecipes < ActiveRecord::Migration[6.1]
  def change
    add_column :foods_recipes, :quantity, :integer, default: 1
  end
end
