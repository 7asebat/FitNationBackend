class ErrorsController < ApplicationController
  def routing
    render_404
  end

  private

  def render_404
    render json: {
      "status": "error",
      "errors": [
        {
          "name": "RouteNotFound",
          "message": "This route is not found"
        }
      ]
    }
  end
end
