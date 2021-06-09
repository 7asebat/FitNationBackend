class Client < ApplicationRecord
  include Discard::Model
  default_scope -> { kept }


  has_one_attached :avatar

  belongs_to :user_auth
  has_many :trainer_client_messages
  has_many :clients_weights_nutritions
  has_many :clients_exercise_instances
  has_many :workout_plans
  belongs_to :active_workout_plan, foreign_key: :active_workout_plan_id, class_name: :WorkoutPlan, optional:true

  def create_workout_plan(client_id:, level:, name:, requires_equipment:)
    WorkoutPlan.create!(client: self, level: level, name: name, requires_equipment: requires_equipment)
  end
end
