class AdminsController < ApplicationController

  def dashboard
    @exercises_count = Exercise.count
    @workout_plans_count = WorkoutPlan.count
    @trainers_count = Trainer.count
    @clients_count = Client.count
    @food_count = Food.count
    
    @exercises_types_count = Exercise.group(:exercise_type).count


    render status: :ok
  end

end