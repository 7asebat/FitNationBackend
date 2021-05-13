class ApplicationController < ActionController::API
  def authenticate_client
    authenticate(roles: [UserAuth.roles[:client]])
  end

  def authenticate_admin
    authenticate(roles: [UserAuth.roles[:admin]])
  end

  def authenticate_trainer
    authenticate(roles: [UserAuth.roles[:trainer]])
  end

  def authenticate_nutritionist
    authenticate(roles: [UserAuth.roles[:nutritionist]])
  end

  def authenticate_any
    authenticate(roles: [])
  end

  def authenticate(roles: [])
    @auth_header = request.headers["Authorization"]
    if @auth_header
      begin
        decoded_token = JWT.decode(token, secret)
        payload = decoded_token.first
        user_id = payload["id"]
        @user_auth = UserAuth.find_by_id!(user_id)

        unless roles.empty?
          unless roles.include?(UserAuth.roles[@user_auth.role])
            render json: {
              "status": "error",
              "errors": [
                {
                  "name": "NotAuthorized",
                  "message": "You are not authorized to view this"
                }
              ]
            }
          end
        end

        @user = @user_auth.fetch_user
      rescue => e
        render json: {
          "status": "error",
          "errors": [
            {
              "name": "#{e}",
              "message": "#{e.message}"
            }
          ]
        }, status: :internal_server_error
      end
    else
      render json: {
        "status": "error",
        "errors": [
          {
            "name": "NoAuthorizationSent",
            "message": "No authorization header sent"
          }
        ]
      }, status: :forbidden
    end
  end

  def secret 
    Rails.application.secrets.secret_key_base
  end

  def token
    @auth_header.split(" ")[1]
  end

  def create_token(payload)
    JWT.encode(payload, secret)
  end
end
