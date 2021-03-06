class Trainer < ApplicationRecord
  has_one_attached :avatar

  belongs_to :user_auth, dependent: :destroy
  has_many :trainer_client_messages
  has_many :workout_plans

  def create_workout_plan(client_id:, level:, name:, requires_equipment:)
    WorkoutPlan.create!(trainer: self, client_id: client_id, level: level, name: name, requires_equipment: requires_equipment)
  end
end
