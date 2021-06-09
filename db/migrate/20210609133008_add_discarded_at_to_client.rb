class AddDiscardedAtToClient < ActiveRecord::Migration[6.1]
  def change
    add_column :clients, :discarded_at, :datetime
    add_index :clients, :discarded_at
  end
end
