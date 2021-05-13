class AddEmailToUserAuth < ActiveRecord::Migration[6.1]
  def change
    add_column :user_auths, :email, :string
  end
end
