class ChangeFoodIdAndRecipeIdColumnsInNutritionSpecification < ActiveRecord::Migration[6.1]
  def change
    change_column_null :nutrition_specifications, :food_id, true
    change_column_null :nutrition_specifications, :recipe_id, true
  end
end
