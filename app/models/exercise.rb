class Exercise < ApplicationRecord
  include Discard::Model
  default_scope -> { kept }


  has_one_attached :image
  has_one_attached :clip
  has_many :workout_plan_exercises
  has_many :clients_exercise_instances
end
