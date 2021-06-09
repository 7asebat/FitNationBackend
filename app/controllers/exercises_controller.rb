class ExercisesController < ApplicationController
  before_action :find_exercise, only: [:show, :update, :destroy, :update_image]
  include Paginateable

  def index
    @limit, @page, @offset = pagination_params

    @records = Exercise.where("LOWER(name) LIKE ?", "%#{params[:q]&.downcase}%").limit(@limit).offset(@offset).all.decorate.as_json
    @total = Exercise.where("LOWER(name) LIKE ?", "%#{params[:q]&.downcase}%").all.count
    @count = @records.count
    render status: :ok
  end

  def show
    render status: :ok
  end

  def create
    @exercise = Exercise.new(exercise_params)
    if @exercise.save
      render status: :created
    else
      render json: { status: "error", error: "Unable to create exercise." }, status: :bad_request
    end
  end

  def update
    @exercise.update(exercise_params)
    render status: :ok
  end

  def update_image
    @exercise.image = params[:image]
    @exercise.save!
  end

  def destroy
    @exercise.discard!
    render status: :ok
  end

  def getExerciseByMuscleGroup
    @limit, @page, @offset = pagination_params

    @records = Exercise.where("JSON_CONTAINS(meta_data,'#{params[:muscle_group]}','$.muscle_groups')").limit(@limit).offset(@offset).all.decorate.as_json
    @total = Exercise.where("JSON_CONTAINS(meta_data,'#{params[:muscle_group]}','$.muscle_groups')").all.count
    @count = @records.count
    
    render status: :ok
  end

  private

  def exercise_params
    request.parameters[:exercise].slice(:name, :tips, :exercise_type, :meta_data, :muscle_group)
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
