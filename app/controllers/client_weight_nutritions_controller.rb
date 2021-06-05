class ClientWeightNutritionsController < ApplicationController
  before_action :authenticate_client, only: [:create, :destroy, :update, :add_spec, :remove_spec, :getAllClientWeightNutrition]
  before_action :find_client_w_n, only: [:show, :update, :destroy, :add_spec, :remove_spec]

  def index
    @client_w_ns = ClientsWeightsNutrition.all
    client_w_ns = @client_w_ns.map { |el| decorate(el) }
    render json: { status: "success", data: { client_weight_nutritions: client_w_ns } }, status: :ok
  end

  def getAllClientWeightNutrition
    @client_w_ns = ClientsWeightsNutrition.where(client_id: @user.id)
    client_w_ns = @client_w_ns.map { |el| decorate(el) }
    render json: { status: "success", data: { client_weight_nutritions: client_w_ns } }, status: :ok
  end

  def show
    render json: { status: "success", data: { client_weight_nutrition: decorate(@client_w_n) } }, status: :ok
  end

  def create
    ActiveRecord::Base.transaction do
      @client_w_n = ClientsWeightsNutrition.new(client_w_n_params)
      @client_w_n.client_id = @user.id

      if (validate_unique_date(@client_w_n.date))
        if @client_w_n.save
          render json: { status: "success", data: { client_weight_nutrition: decorate(@client_w_n) } }, status: :created
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
        render json: { status: "success", data: { client_weight_nutrition: decorate(@client_w_n) } }, status: :ok
      end
    else
      render json: { status: "error", error: "Unauthorized" }, status: :unauthorized
    end
  end

  def destroy
    if @user.id == @client_w_n.client_id
      ActiveRecord::Base.transaction do
        remove_nutrition_specs
        @client_w_n.destroy
        render json: { status: "success", message: "client_weight_nutrition deleted successfully" }, status: :ok
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
          insert_nspec
          find_client_w_n
          render json: { status: "success", data: { client_weight_nutrition: decorate(@client_w_n) } }, status: :ok
        else
          render json: { status: "error", error: "Failed to create nutrition specification" }, status: :bad_request
        end
      end
    end
  end

  def remove_spec
    if @user.id == @client_w_n.client_id
      ActiveRecord::Base.transaction do
        @n_spec = NutritionSpecification.find(params[:nspec_id])
        @n_spec.destroy
        find_client_w_n
        render json: { status: "success", data: { client_weight_nutrition: decorate(@client_w_n) } }, status: :ok
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

  def insert_nspec
    query = "INSERT INTO clients_weights_nutritions_nutrition_specifications VALUES (#{@client_w_n.id},#{@n_spec.id});"
    puts query
    ActiveRecord::Base::connection.exec_query(query)
  end

  def n_spec_params
    request.parameters[:nutrition_specification].slice(:food_id, :recipe_id, :quantity)
  end

  def remove_nutrition_specs
    query = "DELETE FROM clients_weights_nutritions_nutrition_specifications WHERE clients_weights_nutrition_id=#{@client_w_n.id}"
    ActiveRecord::Base::connection.exec_query(query)
  end

  def client_w_n_params
    request.parameters[:client_weight_nutrition].slice(:date, :weight)
  end

  def find_client_w_n
    @client_w_n = ClientsWeightsNutrition.find(params[:id])
  end

  def get_client_weight_nutrition_specs(id)
    query = "SELECT nutrition_specification_id FROM clients_weights_nutritions_nutrition_specifications WHERE clients_weights_nutrition_id=#{id};"
    res = ActiveRecord::Base::connection.exec_query(query)
    return res.to_a
  end

  def decorate(client_w_n)
    ids = get_client_weight_nutrition_specs(client_w_n.id)
    return {
             id: client_w_n.id,
             client_id: client_w_n.client_id,
             date: client_w_n.date,
             weight: client_w_n.weight,
             nutrition_specifications: ids,
           }
  end
end
