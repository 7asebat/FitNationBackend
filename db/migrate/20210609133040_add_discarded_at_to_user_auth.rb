class AddDiscardedAtToUserAuth < ActiveRecord::Migration[6.1]
  def change
    add_column :user_auths, :discarded_at, :datetime
    add_index :user_auths, :discarded_at
  end
end
