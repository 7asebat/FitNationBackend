class WorkoutPlansController < ApplicationController

  include Paginateable

  before_action only: [:create, :me_index] do
    authenticate(roles: [UserAuth.roles[:client], UserAuth.roles[:trainer]])
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
    @total = WorkoutPlan.all.count
    @count = @records.count

    render status: :ok
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
