class ClientWeightNutritionsController < ApplicationController
  include Paginateable
  before_action :authenticate_client, only: [:create, :destroy, :update, :add_spec, :remove_spec, :getAllClientWeightNutrition]
  before_action :find_client_w_n, only: [:show, :update, :destroy, :add_spec, :remove_spec]
  def index
    @limit, @page, @offset = pagination_params

    @records = ClientsWeightsNutrition.limit(@limit).offset(@offset).all.decorate.as_json
    @total = ClientsWeightsNutrition.all.count
    @count = @records.count
    render status: :ok
  end

  def getAllClientWeightNutrition
    @limit, @page, @offset = pagination_params

    @records = ClientsWeightsNutrition.where(client_id: @user.id).limit(@limit).offset(@offset).all.decorate.as_json
    @total = ClientsWeightsNutrition.all.count
    @count = @records.count
    render status: :ok
  end

  def show
    render status: :ok
  end

  def create
    ActiveRecord::Base.transaction do
      @client_w_n = ClientsWeightsNutrition.new(client_w_n_params)
      @client_w_n.client_id = @user.id

      if (validate_unique_date(@client_w_n.date))
        if @client_w_n.save
          render status: :created
        else
          render json: { status: "error", error: " Unable to create client weight nutrition" }, status: :bad_request
        end
      else
        render json: { status: "error", error: "There exist an instance with this date" }, status: :bad_request
      end
    end
  end

  def update
    if @user.id == @client_w_n.client_id
      if params[:client_weight_nutrition].has_key?(:date)
        if !validate_unique_date(params[:client_weight_nutrition][:date])
          render json: { status: "error", error: "There exist an instance with this date" }, status: :bad_request
        end
      elsif @client_w_n.update(client_w_n_params)
        render status: :ok
      end
    else
      render json: { status: "error", error: "Unauthorized" }, status: :unauthorized
    end
  end

  def destroy
    if @user.id == @client_w_n.client_id
      ActiveRecord::Base.transaction do
        @client_w_n.nutrition_specifications.destroy
        @client_w_n.destroy
        render status: :ok
      end
    else
      render json: { status: "error", error: "Unauthorized" }, status: :unauthorized
    end
  end

  def add_spec
    if @user.id == @client_w_n.client_id
      ActiveRecord::Base.transaction do
        @n_spec = NutritionSpecification.new(n_spec_params)
        if @n_spec.save
          @client_w_n.nutrition_specifications.push(@n_spec)
          @client_w_n.save
          render status: :ok
        else
          render json: { status: "error", error: "Failed to create nutrition specification" }, status: :bad_request
        end
      end
    end
  end

  def remove_spec
    if @user.id == @client_w_n.client_id
      ActiveRecord::Base.transaction do
        @client_w_n.nutrition_specifications.destroy(params[:nspec_id])
        render status: :ok
      end
    end
  end

  private

  def validate_unique_date(date)
    query = "SELECT id FROM clients_weights_nutritions WHERE client_id = #{@user.id} AND DATE(date) = \"#{date.to_date}\";"
    res = ActiveRecord::Base::connection.exec_query(query)
    if res.to_a.empty?
      return true
    else
      return false
    end
  end

  def n_spec_params
    request.parameters[:nutrition_specification].slice(:food_id, :recipe_id, :quantity)
  end
  
  def client_w_n_params
    request.parameters[:client_weight_nutrition].slice(:date, :weight)
  end

  def find_client_w_n
    @client_w_n = ClientsWeightsNutrition.find(params[:id])
  end

end
