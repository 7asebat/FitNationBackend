class AuthenticationController < ApplicationController
  before_action :authenticate_any, only: [:current_user]

  def sign_in
    p = sign_in_params
    @user_auth = UserAuth.find_by(email: p[:email])
    if @user_auth
      correct_auth = @user_auth.authenticate(p[:password])

      if correct_auth
        payload = { id: @user_auth.id }
        @token = create_token(payload)
        render status: :ok
      else
        render 'errors/incorrect_credentials', status: :unauthorized
      end
    else
      render 'errors/user_not_found', status: :not_found
    end
  end

  def current_user
    render status: :ok
  end

  private

  def sign_in_params
    params.permit(:email, :password)
  end
end
