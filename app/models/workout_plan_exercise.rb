class WorkoutPlanExercise < ApplicationRecord
  belongs_to :exercise
  belongs_to :workout_plan
  has_many :clients_exercise_instances
end
