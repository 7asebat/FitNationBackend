class ClientsExerciseInstanceController < ApplicationController
  before_action :authenticate_client

  def create
    params = create_params

    @client_exercise_instance = ClientsExerciseInstance.create!(client: @user,
                                                                date: params[:date],
                                                                performance: params[:performance],
                                                                exercise_id: params[:exercise_id],
                                                                workout_plan_exercise_id: params[:workout_plan_exercise_id],
                                                                sets: params[:sets],
                                                                reps: params[:reps],
                                                                duration: params[:duration]
                                                              )
    render status: :created                                                                
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
end
