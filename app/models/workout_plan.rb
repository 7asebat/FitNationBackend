class WorkoutPlan < ApplicationRecord
  belongs_to :client, optional: true
  belongs_to :trainer, optional: true
  has_many :workout_plan_exercises

end
