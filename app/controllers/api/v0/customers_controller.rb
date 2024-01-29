class Api::V0::CustomersController < ApplicationController

  def subscribe
    customer = Customer.find_by("id = #{params[:customer_id]}")
    subscription = Subscription.find_by("id = #{params[:subscription_id]}")

    if customer && subscription
      subscription.update(customer: customer, status: "active")
      successful_subscription
    else
      unsuccessful_response
    end
  end

  def unsubscribe
    customer = Customer.find_by("id = #{params[:customer_id]}")
    subscription = Subscription.find_by("id = #{params[:subscription_id]}")

    if customer && subscription
      subscription.update(status: "cancelled")
      successful_unsubscription
    else
      unsuccessful_response
    end
  end

  def subscriptions
    customer = Customer.find_by("id = #{params[:customer_id]}")
    subscriptions = customer.subscriptions

    if customer && !subscriptions.nil?
      render json: SubscriptionSerializer.new(subscriptions)
    elsif customer && subscriptions.nil?
      no_subscriptions
    else
      unsuccessful_response
    end
  end

  private
  def successful_subscription
    render json:  { message: "Subscription added!" }, status: 201
  end

  def unsuccessful_response
    render json:  { message: "Customer or Subscription could not be found." }, status: 404
  end

  def successful_unsubscription
    render json:  { message: "Subscription cancelled!" }, status: 201
  end

  def no_subscriptions
    render json:  { message: "This customer does not have any subscriptions." }, status: 404
  end
end