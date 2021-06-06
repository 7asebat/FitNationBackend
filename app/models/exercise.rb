class Exercise < ApplicationRecord
  has_many :workout_plan_exercises
  has_many :clients_exercise_instances
end
