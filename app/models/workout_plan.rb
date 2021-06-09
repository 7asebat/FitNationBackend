class WorkoutPlan < ApplicationRecord
  include Discard::Model
  default_scope -> { kept }


  has_one_attached :image 
  
  belongs_to :client, optional: true
  belongs_to :trainer, optional: true
  has_many :workout_plan_exercises

end
