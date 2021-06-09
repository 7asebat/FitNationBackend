class ChangeNutritionSpecificationsRecipesFkToCascade < ActiveRecord::Migration[6.1]
  def change
    remove_foreign_key :nutrition_specifications, :recipes, column: :recipe_id
    add_foreign_key :nutrition_specifications, :recipes, column: :recipe_id, on_delete: :cascade
  end
end
