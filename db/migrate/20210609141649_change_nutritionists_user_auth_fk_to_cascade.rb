class ChangeNutritionistsUserAuthFkToCascade < ActiveRecord::Migration[6.1]
  def change
    remove_foreign_key :nutritionists, :user_auths, column: :user_auth_id
    add_foreign_key :nutritionists, :user_auths, column: :user_auth_id, on_delete: :cascade
  end
end
