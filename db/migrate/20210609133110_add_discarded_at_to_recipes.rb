class AddDiscardedAtToRecipes < ActiveRecord::Migration[6.1]
  def change
    add_column :recipes, :discarded_at, :datetime
    add_index :recipes, :discarded_at
  end
end
