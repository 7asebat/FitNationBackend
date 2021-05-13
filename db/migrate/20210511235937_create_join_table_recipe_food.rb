class CreateJoinTableRecipeFood < ActiveRecord::Migration[6.1]
  def change
    create_join_table :recipes, :foods do |t|
      t.index :recipe_id
      t.index :food_id
    end
  end
end
