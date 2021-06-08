class TrainerClientMessage < ApplicationRecord
  belongs_to :client
  belongs_to :trainer

  enum sent_by: {
    trainer: 0,
    client: 1
  }
end
