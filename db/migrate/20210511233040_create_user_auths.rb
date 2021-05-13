class CreateUserAuths < ActiveRecord::Migration[6.1]
  def change
    create_table :user_auths do |t|
      t.string :password_digest
      t.integer :role
      t.string :reset_password_token
      t.datetime :reset_password_at

      t.timestamps
    end
  end
end
