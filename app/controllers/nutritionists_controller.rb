class NutritionistsController < ApplicationController
  before_action :authenticate_nutritionist

  def sign_up
    ActiveRecord::Base.transaction do
      p = sign_up_params
      @user_auth = UserAuth.create!(email: p[:email], password: p[:password], role: role)
      @user = Nutritionist.create!(name: p[:name], country: p[:country].to_i, user_auth: @user_auth)
    end

    payload = { id: @user_auth.id, role: role }
    @token = create_token(payload)

    render status: :created
  end

  def delete
    ActiveRecord::Base.transaction do
      id = params[:id]
      Nutritionist.discard!(id)
    end
  end

  def dashboard
    @recipes_count = @user.recipes.count
  end
  
  private

  def sign_up_params
    params.permit(:email, :password, :name, :country)
  end

  def role
    UserAuth.roles[:nutritionist]
  end
end
