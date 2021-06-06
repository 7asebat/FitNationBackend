class RecipesController < ApplicationController
  before_action :find_recipe, only: [:show, :update, :destroy, :add_food, :remove_food]
  before_action :authenticate_nutritionist, only: [:create, :destroy, :update, :add_food, :remove_food]

  def index
    @recipes = Recipe.all
    render json: { status: "success", data: { recipes: @recipes.decorate.as_json } }, status: :ok
  end

  def show
    render json: { status: "success", data: { recipe: @recipe.decorate.as_json} }, status: :ok
  end

  def create
    ActiveRecord::Base.transaction do
      @recipe = Recipe.new(recipe_params)
      @recipe.nutritionist_id = @user.id
      if @recipe.save
        insert_joined_recipe_food
        render json: { status: "success", data: { recipe: @recipe.decorate.as_json } }, status: :created
      else
        render json: { status: "error", error: "Unable to create recipe." }, status: :bad_request
      end
    end
  end

  def update
    if !validate_nutritionist_recipe(@recipe)
      render_unauthorized_error
    else
      @recipe.update(recipe_update_params)
      render json: { status: "success", data: { recipe: @recipe.decorate.as_json } }, status: :ok
    end
  end

  def destroy
    if !validate_nutritionist_recipe(@recipe)
      render_unauthorized_error
    else
      @recipe.destroy
      render json: { status: "success", message: "Recipe deleted successfully" }, status: :ok
    end
  end

  def add_food
    if !validate_nutritionist_recipe(@recipe)
      render_unauthorized_error
    else
      insert_joined_recipe_food
      @recipe = Recipe.find(params[:id])
      render json: { status: "success", data: { recipe: @recipe.decorate.as_json } }, status: :ok
    end
  end

  def remove_food
    if !validate_nutritionist_recipe(@recipe)
      render_unauthorized_error
    else
      delete_joined_recipe_food(params[:recipe][:foods])
      @recipe = Recipe.find(params[:id])
      render json: { status: "success", data: { recipe: @recipe.decorate.as_json } }, status: :ok
    end
  end

  def get_recipes_nutritionist
    nutritionist_id = params[:nutritionist_id]
    nutritionist = Nutritionist.find(nutritionist_id)
    @recipes = Recipe.where(nutritionist_id: nutritionist_id)
    recipes = @recipes.map { |recipe| decorate(recipe) }
    render json: { status: "success", data: { recipes: recipes } }, status: :ok
  end

  private

  def recipe_params
    request.parameters[:recipe].slice(:name, :description, :photo)
  end

  def find_recipe
    @recipe = Recipe.find(params[:id])
  end

  def recipe_update_params
    request.parameters[:recipe].slice(:name, :description, :photo)
  end

  def delete_joined_recipe_food(ids)
    query = "DELETE FROM foods_recipes WHERE food_id IN ("
    ids.each_with_index { |id, index|
      if index == ids.length() - 1
        query += "#{id})"
      else
        query += "#{id},"
      end
    }
    ActiveRecord::Base::connection.execute(query)
  end

  def insert_joined_recipe_food
    foods = Food.find(params[:recipe][:foods])

    query = "INSERT INTO foods_recipes VALUES "
    params[:recipe][:foods].each_with_index { |id, index|
      if index == foods.length() - 1
        query += "(#{@recipe.id},#{id})"
      else
        query += "(#{@recipe.id},#{id}),"
      end
    }
    query += ";"

    ActiveRecord::Base::connection.execute(query)
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

  def decorate(recipe)
    {
      id: recipe.id,
      name: recipe.name,
      description: recipe.description,
      photo: recipe.photo,
      foods: recipe.foods,
      nutritionist_id: recipe.nutritionist_id,
    }
  end
end
