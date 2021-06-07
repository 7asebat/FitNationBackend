class ExercisesController < ApplicationController
  before_action :find_exercise, only: [:show, :update, :destroy]

  def index
    @exercises = Exercise.all
    exercises = @exercises.map { |exercise| decorate(exercise) }
    render json: { status: "success", data: { exercises: exercises } }, status: :ok
  end

  def show
    render json: { status: "success", data: { exercise: decorate(@exercise) } }, status: :ok
  end

  def create
    @exercise = Exercise.new(exercise_params)
    if @exercise.save
      render json: { status: "success", data: { exercise: decorate(@exercise) } }, status: :created
    else
      render json: { status: "error", error: "Unable to create exercise." }, status: :bad_request
    end
  end

  def update
    @exercise.update(exercise_params)
    render json: { status: "success", data: { exercise: decorate(@exercise) } }, statu: :ok
  end

  def destroy
    @exercise.destroy
    render json: { status: "success", message: "Exercise deleted successfully." }, status: :ok
  end

  def getExerciseByMuscleGroup
    puts "(meta_data->'muscle_groups')::jsonb @> '#{params[:muscle_group]}'"
    @exercises = Exercise.where("JSON_CONTAINS(meta_data,'#{params[:muscle_group]}','$.muscle_groups')")
    exercises = @exercises.map { |exercise| decorate(exercise) }
    render json: { status: "success", data: { exercises: exercises } }, status: :ok
  end

  private

  def exercise_params
    request.parameters.slice(:name, :tips, :exercise_type, :meta_data, :muscle_group, :image)
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
      meta_data: exercise.meta_data,
    }
  end
end
