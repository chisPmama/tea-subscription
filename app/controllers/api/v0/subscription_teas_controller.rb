class Api::V0::SubscriptionTeasController < ApplicationController

  def create
    tea = Tea.find(params[:tea_id])
    subscription = Subscription.find(params[:subscription_id])

    if customer && subscription
      subscription.update(customer: customer, status: "active")
      successful_subscription
    else
      unsuccessful_response
    end
  end

end