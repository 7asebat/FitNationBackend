class AuthenticationController < ApplicationController
  before_action :authenticate_any, only: [:current_user]

  def sign_in
    p = sign_in_params
    @user_auth = UserAuth.find_by(email: p[:email])
    if @user_auth
      correct_auth = @user_auth.authenticate(p[:password])

      if correct_auth
        payload = { id: @user_auth.id }
        token = create_token(payload)
        render json: {
          status: "success",
          data: {
            user: @user_auth.fetch_user.decorate,
            token: token,
          },
        }
      else
        render json: {
          "status": "error",
          "errors": [
            {
              "name": "IncorrectCredentials",
              "message": "The credentials you entered are incorrect",
            },
          ],
        }, status: :unauthorized
      end
    else
      render json: {
        "status": "error",
        "errors": [
          {
            "name": "UserNotFound",
            "message": "No user was found with this email",
          },
        ],
      }, status: :not_found
    end
  end

  def current_user
    render json: {
      "status": "success",
      "data": {
        "user": @user.decorate
      }
    }
  end

  private

  def sign_in_params
    params.permit(:email, :password)
  end
end
