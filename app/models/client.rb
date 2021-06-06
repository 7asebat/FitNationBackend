class Client < ApplicationRecord
  has_one_attached :avatar

  belongs_to :user_auth
  has_many :trainer_client_messages
  has_many :clients_weights_nutritions
  has_many :clients_exercise_instances
  has_many :workout_plans

  def create_workout_plan(client_id:, level:, name:, requires_equipment:)
    WorkoutPlan.create!(client: self, level: level, name: name, requires_equipment: requires_equipment)
  end
end
