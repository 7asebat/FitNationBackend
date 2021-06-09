class ChangeTrainerClientMessagesTrainerFkToCascade < ActiveRecord::Migration[6.1]
  def change
    remove_foreign_key :trainer_client_messages, :trainers, column: :trainer_id
    add_foreign_key :trainer_client_messages, :trainers, column: :trainer_id, on_delete: :cascade
  end
end
