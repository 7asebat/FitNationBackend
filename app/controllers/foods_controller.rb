class FoodsController < ApplicationController
  before_action :find_food, only: [:show, :update, :destroy]
  include Paginateable

  def index
    @limit, @page, @offset = pagination_params

    @records = Food.where("LOWER(name) LIKE ?", "%#{params[:q]&.downcase}%").limit(@limit).offset(@offset).all.decorate.as_json
    @total = Food.where("LOWER(name) LIKE ?", "%#{params[:q]&.downcase}%").all.count
    @count = @records.count

    render status: :ok
  end

  def show
      render status: :ok
  end

  def create
    @food = Food.new(food_params)
    if @food.save
      render status: :created
    else
      render json: { status: "error", error: "Unable to create food." }, status: :bad_request
    end
  end

  def update
      @food.update(food_params)
      render status: :ok
  end

  def destroy
      @food.discard!
      render status: :ok
  end

  private

  def food_params
    request.parameters.slice(:has_image, :name, :nutrition_facts, :food_type, :image)
  end

  def find_food
    @food = Food.find(params[:id])
  end
end
