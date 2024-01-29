class ApplicationController < ActionController::API

  def successful_subscription
    render json:  { message: "Subscription added!" }, status: 201
  end
  
end
