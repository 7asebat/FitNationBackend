class WorkoutPlan < ApplicationRecord
  belongs_to :client
  belongs_to :trainer
  has_many :workout_plan_exercises
end
