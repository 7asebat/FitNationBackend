class RecipesController < ApplicationController
  before_action :find_recipe, only: [:show, :update, :destroy, :add_food]

  def index
    @recipes = Recipe.all
    recipes = @recipes.map { |recipe| decorate(recipe) }
    render json: { status: "success", data: { recipes: recipes } }, status: :ok
  end

  def show
      render json: { status: "success", data: { recipe: decorate(@recipe) } }, status: :ok
  end

  def create
    ActiveRecord::Base.transaction do
      @recipe = Recipe.new(recipe_params)
      if @recipe.save
        insert_joined_recipe_food
        render json: { status: "success", data: { recipe: decorate(@recipe) } }, status: :created
      else
        render json: { status: "error", error: "Unable to create recipe." }, status: :bad_request
      end
    end
  end

  def update
      @recipe.update(recipe_update_params)
      render json: { status: "success", data: { recipe: decorate(@recipe) } }, status: :ok
  end

  def destroy
      @recipe.destroy
      render json: { status: "success", message: "Recipe deleted successfully" }, status: :ok
  end

  def add_food
    insert_joined_recipe_food
    @recipe = Recipe.find(params[:id])
    render json: { status: "success", data: { recipe: decorate(@recipe) } }, status: :ok
  end

  def remove_food
    delete_joined_recipe_food(params[:recipe][:foods])
    @recipe = Recipe.find(params[:id])
    render json: { status: "success", data: { recipe: decorate(@recipe) } }, status: :ok
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
    request.parameters[:recipe].slice(:name, :description, :photo, :nutritionist_id)
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
