class ClientsExerciseInstance < ApplicationRecord
  belongs_to :client
  belongs_to :workout_plan_exercise, optional: true
  belongs_to :exercise, optional: true
end
