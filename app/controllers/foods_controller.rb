class FoodsController < ApplicationController
  before_action :find_food, only: [:show, :update, :destroy]

  def index
    @foods = Food.all
    render json: { status: "success", data: { food: @foods.decorate.as_json } }, status: :ok
  end

  def show
      render json: { status: "success", data: { food: @food.decorate.as_json } }, status: :ok
  end

  def create
    @food = Food.new(food_params)
    if @food.save
      render json: { status: "success", data: { food: @food.decorate.as_json } }, status: :created
    else
      render json: { status: "error", error: "Unable to create food." }, status: :bad_request
    end
  end

  def update
      @food.update(food_params)
      render json: { status: "success", data: { food: @food.decorate.as_json } }, statu: :ok
  end

  def destroy
      @food.destroy
      render json: { status: "success", message: "Food deleted successfully." }, status: :ok
  end

  private

  def food_params
    request.parameters.slice(:has_image, :name, :nutrition_facts, :food_type, :image)
  end

  def find_food
    @food = Food.find(params[:id])
  end
end
