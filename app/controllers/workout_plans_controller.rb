class WorkoutPlansController < ApplicationController
  before_action :authenticate_client, only: [:create, :index]

  def create
    days = create_params

    ActiveRecord::Base.transaction do
      workout_plan = WorkoutPlan.create!(client: @user)
      days.each do |day, v_d|
        exercises = v_d[:exercises]
        exercises.each do |exercise_obj|
          workout_plan.workout_plan_exercises.create!(
            day: day,
            exercise_id: exercise_obj[:exercise_id],
            sets: exercise_obj[:set],
            reps: exercise_obj[:reps],
            duration: exercise_obj[:duration],
          )
        end
      end
    end
    render status: :created
  end

  def index
    @workout_plans = @user.workout_plans.includes(:client, :trainer).all
    render status: :ok
  end

  private

  def create_params
    params.require("days")
  end
end
