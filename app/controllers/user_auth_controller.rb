class UserAuthController < ApplicationController
  include Paginateable

  def index
    role = params[:role]

    @limit, @page, @offset = pagination_params

    throw StandardError if role.blank?

    puts UserAuth.roles[:client].to_s
    puts role
    puts role == UserAuth.roles[:client]

    if role == UserAuth.roles[:client].to_s
      userModel = Client
    elsif role == UserAuth.roles[:nutritionist].to_s
      userModel = Nutritionist
    elsif role == UserAuth.roles[:admin].to_s
      userModel = Admin
    elsif role == UserAuth.roles[:trainer].to_s
      userModel = Trainer
    else
      render status: 400
    end

    @records = userModel.limit(@limit).offset(@offset).all.decorate.as_json

    render status: :ok
  end
end
