class CreateAdmins < ActiveRecord::Migration[6.1]
  def change
    create_table :admins do |t|
      t.references :user_auth, null: false, foreign_key: true
      t.string :name

      t.timestamps
    end
  end
end
