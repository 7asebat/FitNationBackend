class AddDiscardedAtToNutritionSpecifications < ActiveRecord::Migration[6.1]
  def change
    add_column :nutrition_specifications, :discarded_at, :datetime
    add_index :nutrition_specifications, :discarded_at
  end
end
