class Api::V0::CustomersController < ApplicationController

  def subscribe
    customer = Customer.find_by("id = #{params[:customer_id]}")
    subscription = Subscription.find_by("id = #{params[:subscription_id]}")

    if customer && subscription
      subscription.update(customer: customer, status: "active")
      successful_subscription(customer, subscription)
    else
      unsuccessful_response
    end
  end

  def unsubscribe
    customer = Customer.find_by("id = #{params[:customer_id]}")
    subscription = Subscription.find_by("id = #{params[:subscription_id]}")

    if customer && subscription
      subscription.update(status: "cancelled")
      successful_unsubscription(customer, subscription)
    else
      unsuccessful_response
    end
  end

  def subscriptions
    customer = Customer.find_by("id = #{params[:customer_id]}")

    if customer.nil?
      unsuccessful_response
    elsif customer.subscriptions.blank?
      no_subscriptions
    else
      render json: SubscriptionSerializer.new(customer.subscriptions)
    end
  end

  private
  def unsuccessful_response
    render json:  { message: "Customer or Subscription could not be found." }, status: 404
  end

  def successful_unsubscription(customer, subscription)
    message = "Subscription '#{subscription.title}' for customer '#{customer.first_name} #{customer.last_name}' has been cancelled."
    render json: { message: message }, status: 201
  end

  def no_subscriptions
    render json:  { message: "This customer does not have any subscriptions." }, status: 404
  end
end