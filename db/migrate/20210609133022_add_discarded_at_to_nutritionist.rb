class AddDiscardedAtToNutritionist < ActiveRecord::Migration[6.1]
  def change
    add_column :nutritionists, :discarded_at, :datetime
    add_index :nutritionists, :discarded_at
  end
end
