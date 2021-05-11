class CreateTrainers < ActiveRecord::Migration[6.1]
  def change
    create_table :trainers do |t|
      t.string :name
      t.references :user_auth, null: false, foreign_key: true
      t.integer :country

      t.timestamps
    end
  end
end
