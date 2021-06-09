class AddDiscardedAtToFood < ActiveRecord::Migration[6.1]
  def change
    add_column :foods, :discarded_at, :datetime
    add_index :foods, :discarded_at
  end
end
