class ClientsController < ApplicationController
  before_action :authenticate_client, only: [:setActiveWorkoutPlan, :dashboard, :update_image]

  def sign_up
    ActiveRecord::Base.transaction do
      p = sign_up_params
      @user_auth = UserAuth.create!(email: p[:email], password: p[:password], role: role)
      @user = Client.create!(name: p[:name], country: p[:country].to_i, avatar: p[:avatar] ,user_auth: @user_auth)
    end

    payload = { id: @user_auth.id, role: role }
    @token = create_token(payload)

    render status: :created
  end

  def delete
    ActiveRecord::Base.transaction do
      id = params[:id]
      @client = Client.find(id)
      @client.discard!
    end
  end

  def update_image
    @user.avatar = params[:avatar]
    @user.save!
  end

  def dashboard
    @exercise_instances_count = @user.clients_exercise_instances.count
    clients_exercise_instances = @user.clients_exercise_instances.order(:date).all

    @longest_streak = 0
    last_exercise_date = Date.new(1970, 1, 1)

    current_streak = 1

    clients_exercise_instances.each do |u|
      number_of_days = (u.date.to_date - last_exercise_date).to_i

      if number_of_days == 1
        current_streak += 1
      elsif number_of_days > 1
        @longest_streak = [current_streak, @longest_streak].max
        current_streak = 1
      end

      last_exercise_date = u.date.to_date
      @longest_streak = [current_streak, @longest_streak].max
    end

  end

  def setActiveWorkoutPlan
    @user.update_column(:active_workout_plan_id,params[:workout_plan_id])
      render json:{status:"success",message:"Active workout plan is set succesfully"},status: :ok
  end
  
  private

  def sign_up_params
    params.permit(:email, :password, :name, :country, :avatar)
  end

  def role
    UserAuth.roles[:client]
  end
end
