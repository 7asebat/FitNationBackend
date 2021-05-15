class WorkoutPlan < ApplicationRecord
  belongs_to :client
  belongs_to :trainer, optional: true
  has_many :workout_plan_exercises
end
