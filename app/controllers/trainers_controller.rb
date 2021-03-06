class TrainersController < ApplicationController
  def sign_up
    ActiveRecord::Base.transaction do
      p = sign_up_params
      @user_auth = UserAuth.create!(email: p[:email], password: p[:password], role: role)
      @user = Trainer.create!(name: p[:name], country: p[:country].to_i, user_auth: @user_auth)
    end

    payload = { id: @user_auth.id, role: role }
    @token = create_token(payload)

    render status: :created
  end

  def index
    @trainers = Trainer.where("LOWER(name) LIKE ?", "%#{params[:q]&.downcase}%").all.decorate.as_json
  end

  def delete
    ActiveRecord::Base.transaction do
      id = params[:id]
      Trainer.destroy(id)
    end
  end
  
  private

  def sign_up_params
    params.permit(:email, :password, :name, :country)
  end

  def role
    UserAuth.roles[:trainer]
  end
end
