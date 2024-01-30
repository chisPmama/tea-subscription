class ApplicationController < ActionController::API

  def successful_subscription(customer, subscription)
    render json:  { message: "Subscription '#{subscription.title}' added for customer '#{customer.first_name} #{customer.last_name}'!" }, status: 201
  end

  def successful_subscription_tea(tea, subscription)
    render json:  { message: "'#{tea.title}' added to subscription '#{subscription.title}'!" }, status: 201
  end
  
end
