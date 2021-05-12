class Trainer < ApplicationRecord
  belongs_to :user_auth
  has_many :trainer_client_messages
  has_many :workout_plans
end
