class AddSentByToTrainerClientMessage < ActiveRecord::Migration[6.1]
  def change
    add_column :trainer_client_messages, :sent_by, :integer
  end
end
