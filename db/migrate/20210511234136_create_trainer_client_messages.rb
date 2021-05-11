class CreateTrainerClientMessages < ActiveRecord::Migration[6.1]
  def change
    create_table :trainer_client_messages do |t|
      t.references :client, null: false, foreign_key: true
      t.references :trainer, null: false, foreign_key: true
      t.string :body

      t.timestamps
    end
  end
end
