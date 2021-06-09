class ChangeClientsWeightsNutritionsFkToCascade < ActiveRecord::Migration[6.1]
  def change
    remove_foreign_key :clients_weights_nutritions, :clients, column: :client_id
    add_foreign_key :clients_weights_nutritions, :clients, column: :client_id, on_delete: :cascade
  end
end
