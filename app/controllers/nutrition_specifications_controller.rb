class NutritionSpecificationsController < ApplicationController
  before_action :find_nutrition_specification, only: [:show, :update, :destroy]
  before_action :authenticate_client, only: [:create, :destroy, :update]

  def index
    @n_specs = NutritionSpecification.all
    n_specs = @n_specs.map { |n_spec| decorate(n_spec) }
    render json: { status: "success", data: { nutrition_specifications: n_specs } }, status: :ok
  end

  def show
    render json: { status: "success", data: { nutrition_specification: decorate(@n_spec) } }, status: :ok
  end

  def update
    recipe_id = params[:nutrition_specification][:recipe_id]
    @recipe = (recipe_id) ? Recipe.find(recipe_id) : nil
    if recipe_id && !validate_nutritionist_recipe(@recipe)
      render_unauthorized_error
    else
      @n_spec.update(n_spec_params)
      render json: { status: "success", data: { nutrition_specification: decorate(@n_spec) } }, status: :ok
    end
  end

  def create
    recipe = Recipe.find(params[:nutrition_specification][:recipe_id])

    if !validate_nutritionist_recipe(recipe)
      render_unauthorized_error
    else
      @n_spec = NutritionSpecification.new(n_spec_params)
      if @n_spec.save
        render json: { status: "success", data: { nutrition_specifications: decorate(@n_spec) } }, status: :ok
      else
        render json: { status: "error", error: "Unable to create nutrition specification" }, status: :bad_request
      end
    end
  end

  def destroy
    recipe = Recipe.find(@n_spec.recipe_id)
    if (!validate_nutritionist_recipe(recipe))
      render_unauthorized_error
    else
      @n_spec.destroy
      render json: { status: "success", message: "Nutrition specification deleted successfully" }, status: :ok
    end
  end

  private

  def n_spec_params
    request.parameters[:nutrition_specification].slice(:food_id, :recipe_id, :quantity)
  end

  def find_nutrition_specification
    @n_spec = NutritionSpecification.find(params[:id])
  end
  def validate_nutritionist_recipe(recipe)
    @user.id == recipe.nutritionist_id
  end

  def render_unauthorized_error
    render json: { status: "error", errors: [
             {
               name: "Unauthorized",
               message: "This recipe doesn't belong to the logged in nutritionist.",
             },
           ] }, status: :unauthorized
  end

  def decorate(n_spec)
    {
      id: n_spec.id,
      food_id: n_spec.food_id,
      recipe_id: n_spec.recipe_id,
      quantity: n_spec.quantity,
    }
  end
end
