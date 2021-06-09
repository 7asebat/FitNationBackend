class ClientsExerciseInstanceController < ApplicationController
  before_action :authenticate_client

  def create
    p = create_params

    @client_exercise_instance = ClientsExerciseInstance.create!(client: @user,
                                                                date: p[:date],
                                                                performance: p[:performance],
                                                                exercise_id: p[:exercise_id].present? ? p[:exercise_id] : p[:workout_plan_exercise_id],
                                                                workout_plan_exercise_id: p[:workout_plan_exercise_id],
                                                                sets: p[:sets],
                                                                reps: p[:reps],
                                                                duration: p[:duration]
                                                              )
    render status: :created                                                                
  end

  def me_index
    p = me_index_params
    @date = p[:date].split('T')[0]
    @client_exercise_instances = ClientsExerciseInstance.includes({ workout_plan_exercise: :exercise }, :exercise, :client).where("DATE(`date`) = ?", @date).where(client: @user).all.decorate.as_json
  end

  def create_params
    if params[:date].blank?
      raise ActionController::BadRequest.new(), "Date cannot be blank"
    end

    if  (params[:exercise_id].blank? and params[:workout_plan_exercise_id].blank?)
      raise ActionController::BadRequest.new(), "You must provide an exercise or a workout plan exercise"
    end

    if (params[:exercise_id].present? and params[:workout_plan_exercise_id].present?)
      raise ActionController::BadRequest.new(), "You cannot submit an exercise and a workout plan exercise at the same time"
    end

    if params[:sets].blank? and params[:reps].blank? and params[:duration].blank?
      raise ActionController::BadRequest.new(), "Please add sets and reps or duration"
    end

    params
  end

  def me_index_params
    if params[:date].blank?
      raise ActionController::BadRequest.new(), "You must provide a date"
    end

    params
  end
end
