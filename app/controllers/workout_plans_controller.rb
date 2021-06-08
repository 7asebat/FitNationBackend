class WorkoutPlansController < ApplicationController

  include Paginateable

  before_action only: [:create, :me_index] do
    authenticate(roles: [UserAuth.roles[:client], UserAuth.roles[:trainer]])
  end

  def get
    id = params[:id]

    @workout_plan = WorkoutPlan.includes({workout_plan_exercises: :exercise}).find(id)

    render status: :created
  end

  def create

    p = create_params
    days = p[:days]
    client_id = p[:client_id]
    level = p[:level]
    name = p[:name]
    requires_equipment = p[:requires_equipment]

    ActiveRecord::Base.transaction do
      @workout_plan = @user.create_workout_plan(client_id: client_id, level: level, name: name, requires_equipment: requires_equipment)

      days.each do |day, v_d|
        exercises = v_d[:exercises]
        exercises.each do |exercise_obj|
          @workout_plan.workout_plan_exercises.create!(
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
    @limit, @page, @offset = pagination_params

    @records = WorkoutPlan.where.not(trainer_id: nil).where(client_id: nil).limit(@limit).offset(@offset).all.decorate.as_json
    @total = WorkoutPlan.where.not(trainer_id: nil).where(client_id: nil).count
    @count = @records.count

    render status: :ok
  end

  def update_image
    workout_plan = WorkoutPlan.find(params[:id])
    workout_plan.image = params[:image]
    workout_plan.save!
  end

  def delete
    @workout_plan = WorkoutPlan.find(params[:id])
    WorkoutPlanExercise.where(workout_plan: @workout_plan).delete_all
    Client.where(active_workout_plan: @workout_plan).update_all(active_workout_plan_id: nil)
    @workout_plan.destroy!
  end

  def me_index
    @workout_plans = @user.workout_plans.includes(:client, :trainer).all
    render status: :ok
  end

  private

  def create_params
    params
  end
end
