class Trainer < ApplicationRecord
  belongs_to :user_auth
  has_many :trainer_client_messages
  has_many :workout_plans

  def create_workout_plan(client_id:)
    WorkoutPlan.create!(trainer: self, client_id: client_id)
  end
end
