class RecipesController < ApplicationController
  include Paginateable

  before_action :find_recipe, only: [:show, :update, :destroy, :add_food, :remove_food, :update_image]
  before_action :authenticate_nutritionist, only: [:create, :destroy, :update, :add_food, :remove_food]

  def index
    @limit, @page, @offset = pagination_params

    @records = Recipe.limit(@limit).offset(@offset).all.decorate.as_json
    @total = Recipe.all.count
    @count = @records.count

    render status: :ok
  end

  def show
    render status: :ok
  end

  def update_image
    @recipe.image = params[:image]
    @recipe.save!
  end

  def create
    ActiveRecord::Base.transaction do
      @recipe = Recipe.new(recipe_params)
      @recipe.nutritionist_id = @user.id
      if @recipe.save
        insert_joined_recipe_food
        render status: :created
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
    recipes = @recipes.map { |recipe| recipe.decorate.as_json }
    render json: { status: "success", data: { recipes: recipes } }, status: :ok
  end

  private

  def recipe_params
    request.parameters.dig(:recipe).slice(:name, :description)
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
    foods = params.dig(:recipe, :foods)

    foods.each do |u|
      FoodsRecipes.create!(recipe: @recipe, food_id: u[:id], quantity: u[:quantity])
  end 
    
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
