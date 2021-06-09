class Exercise < ApplicationRecord
  has_one_attached :image
  has_one_attached :clip
  has_many :workout_plan_exercises, dependent: :destroy
  has_many :clients_exercise_instances, dependent: :destroy
end
