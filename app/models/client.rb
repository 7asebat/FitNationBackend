class Client < ApplicationRecord
  belongs_to :user_auth
  has_many :trainer_client_messages
  has_many :clients_weights_nutritions
  has_many :clients_exercise_instances
  has_many :workout_plans
end
