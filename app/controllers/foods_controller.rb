class FoodsController < ApplicationController
    before_action :find_food, only:[:show,:update,:destroy]

    def index
        @foods = Food.all
        puts @foods[0].id
        foods = @foods.map {|food| decorate(food)}
        render json: {status: 'success', data:{food:foods}},status: :ok
    end

    def show
        if @food
            render json: {status: 'success', data: {food: decorate(@food)}}, status: :ok
        else
            render json: {status: 'error', error: 'No food was found with this id.'}, status: :not_found
        end
    end

    def create
        @food = Food.new(food_params)
        if @food.save
            render json: {status: 'success', data:{food: decorate(@food)}}, status: :created
        else
            render json: {status: 'error', error: 'Unable to create food.'}, status: :bad_request
        end
    end

    def update
        if @food
            @food.update(food_params)
            render json: {status:'success', data:{food: decorate(@food)}}, statu: :ok
        else
            render json: {status: 'error', error: 'Unable to update food.'}, status: :bad_request
        end
    end

    def destroy
        if @food
            @food.destroy
            render json: {status: 'success', message: 'Food deleted successfully.'}, status: :ok
        else
            render json: {status: 'error' , error: 'No food was found with this id.'}, status: :not_found
        end 
    end

    private

    def food_params
        request.parameters[:food].slice(:has_image,:name,:nutrition_facts,:food_type)
    end

    def find_food
        @food = Food.find(params[:id])
    end
   
    def decorate(food)
        {
            id: food.id,
            has_image: food.has_image,
            name: food.name,
            nutrition_facts: food.nutrition_facts,
            food_type: food.food_type
        }
    end
end
