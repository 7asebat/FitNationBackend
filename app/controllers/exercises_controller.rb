class ExercisesController < ApplicationController
    before_action :find_exercise, only: [:show,:update,:destroy]

  def index
    @exercises = Exercise.all
    exercises = @exercises.map {|exercise| decorate(exercise)}
    render json: {status: 'success', data:{exercises:exercises}}, status: :ok
  end

  def show
    if @exercise
        render json: {status: 'success', data: {exercise: decorate(@exercise)}}, status: :ok
    else
        render json: {status: 'error', error: 'No exercise was found with this id.'}, status: :not_found
    end
  end

  def create
    @exercise = Exercise.new(exercise_params)
    if @exercise.save
        render json: {status:'success', data: {exercise: decorate(@exercise)}}, status: :created
    else
        render json: {status: 'error', error: 'Unable to create exercise.'}, status: :bad_request
    end
  end

  def update
    if @exercise
        @exercise.update(exercise_params)
        render json: {status:'success', data:{exercise: decorate(@exercise)}}, statu: :ok
    else
        render json: {status: 'error', error: 'Unable to update exercise.'}, status: :bad_request
    end
  end

  def destroy
    if @exercise
        @exercise.destroy
        render json: {status: 'success', message: 'Exercise deleted successfully.'}, status: :ok
    else
        render json: {status: 'error' , error: 'No exercise was found with this id.'}, status: :not_found
    end 
  end

  

  private

  # TODO: Still meta_data comes empty
  def exercise_params
    request.parameters[:exercise].slice(:name,:tips,:exercise_type,:meta_data)
  end

  def find_exercise
    @exercise = Exercise.find(params[:id])
  end

  def decorate(exercise)
    {
        id: exercise.id,
        name: exercise.name,
        tips: exercise.tips,
        exercise_type: exercise.exercise_type,
        meta_data: exercise.meta_data
    }
  end

end
