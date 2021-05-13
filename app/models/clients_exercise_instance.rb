class ClientsExerciseInstance < ApplicationRecord
  belongs_to :client
  belongs_to :workout_plan_exercise
end
