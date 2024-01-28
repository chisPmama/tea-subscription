class Api::V0::CustomersController < ApplicationController

  def subscribe
    customer = Customer.find_by("id = #{params[:customer_id]}")
    subscription = Subscription.find_by("id = #{params[:subscription_id]}")

    if customer && subscription
      subscription.update(customer: customer)
      successful_subscription
    else
      unsuccessful_subscription
    end
  end

  private
  def successful_subscription
    render json:  { message: "Subscription added!" }, status: 201
  end

  def unsuccessful_subscription
    render json:  { message: "Customer or Subscription could not be found." }, status: 404
  end
end