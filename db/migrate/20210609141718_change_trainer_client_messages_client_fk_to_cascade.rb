class ChangeTrainerClientMessagesClientFkToCascade < ActiveRecord::Migration[6.1]
  def change
    remove_foreign_key :trainer_client_messages, :clients, column: :client_id
    add_foreign_key :trainer_client_messages, :clients, column: :client_id, on_delete: :cascade
  end
end
