class WorkoutPlan < ApplicationRecord
  has_one_attached :image 
  
  belongs_to :client, optional: true
  belongs_to :trainer, optional: true
  has_many :workout_plan_exercises, dependent: :destroy

end
