class Exercise < ApplicationRecord
  has_one_attached :image
  has_many :workout_plan_exercises
  has_many :clients_exercise_instances
end
