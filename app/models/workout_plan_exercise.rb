class WorkoutPlanExercise < ApplicationRecord
  belongs_to :exercise
  belongs_to :workout_plan
end
