class ChangeNutritionSpecificationsFoodsFkToCascade < ActiveRecord::Migration[6.1]
  def change
    remove_foreign_key :nutrition_specifications, :foods, column: :food_id
    add_foreign_key :nutrition_specifications, :foods, column: :food_id, on_delete: :cascade
  end
end
