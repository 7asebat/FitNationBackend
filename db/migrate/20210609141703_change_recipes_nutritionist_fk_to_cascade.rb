class ChangeRecipesNutritionistFkToCascade < ActiveRecord::Migration[6.1]
  def change
    remove_foreign_key :recipes, :nutritionists, column: :nutritionist_id
    add_foreign_key :recipes, :nutritionists, column: :nutritionist_id, on_delete: :cascade
  end
end
