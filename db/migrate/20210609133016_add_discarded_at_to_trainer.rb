class AddDiscardedAtToTrainer < ActiveRecord::Migration[6.1]
  def change
    add_column :trainers, :discarded_at, :datetime
    add_index :trainers, :discarded_at
  end
end
