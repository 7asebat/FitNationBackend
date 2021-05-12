class CreateClientsWeightsNutritions < ActiveRecord::Migration[6.1]
  def change
    create_table :clients_weights_nutritions do |t|
      t.references :client, null: false, foreign_key: true
      t.datetime :date
      t.integer :weight

      t.timestamps
    end
  end
end
