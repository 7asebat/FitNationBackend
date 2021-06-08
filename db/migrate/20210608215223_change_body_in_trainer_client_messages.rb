class ChangeBodyInTrainerClientMessages < ActiveRecord::Migration[6.1]
  def change
    change_column :trainer_client_messages, :body, :text
  end
end
