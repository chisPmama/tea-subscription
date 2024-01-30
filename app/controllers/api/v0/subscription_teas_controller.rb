class Api::V0::SubscriptionTeasController < ApplicationController

  def create
    tea = Tea.find(params[:tea_id])
    subscription = Subscription.find(params[:subscription_id])

    if SubscriptionTea.find_by(tea_id: tea.id, subscription_id: subscription.id)
      already_exists
    else
      sub_tea = SubscriptionTea.create(tea_id: tea.id, subscription_id: subscription.id)
      successful_subscription_tea(tea, subscription)
    end
  end

  private
  def already_exists
    render json:  { message: "Subscription already exists." }, status: 422
  end

end