class Api::V0::CustomersController < ApplicationController

  def subscribe
    customer = Customer.find_by("id = #{params[:customer_id]}")
    subscription = Subscription.find_by("id = #{params[:subscription_id]}")

    if customer.exist? && subscription.exist?
      subscription.update(customer: customer)
      successful_subscription
    else
      not_successful_subscription
    end
  end

  private
  def successful_subscription
    render json:  { message: "Subscription added!" }, status: 201
  end

  def not_successful_subscription
    render json:  { message: "Customer or Subscription could not be found." }, status: 404
  end
end