class ClientsController < ApplicationController
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
  
  private

  def sign_up_params
    params.permit(:email, :password, :name, :country, :avatar)
  end

  def role
    UserAuth.roles[:client]
  end
end
