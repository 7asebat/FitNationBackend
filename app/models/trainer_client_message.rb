class TrainerClientMessage < ApplicationRecord
  belongs_to :client
  belongs_to :trainer
end
