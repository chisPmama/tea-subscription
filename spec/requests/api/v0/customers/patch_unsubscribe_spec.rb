require "rails_helper"

RSpec.describe "Customer Cancellation of Subscription" do
  before(:each) do
    customer_data
    subscription_data
    @subscription1.update(customer: @customer1, status: "active")
  end
  
  it 'gives a successful response' do
    update_params = { customer_id: @customer1.id, subscription_id: @subscription1.id }
    patch api_v0_unsubscribe_path, params: update_params

    expect(response).to be_successful
    expect(response.status).to eq(201)
    expect(@customer1.subscriptions.count).to eq(1)

    subscription = @customer1.subscriptions.first
    expect(subscription.status).to eq("cancelled")

    response_data = JSON.parse(response.body, symbolize_names: true)

    expect(response_data).to have_key(:message)
    expect(response_data[:message]).to be_a String
    expect(response_data[:message]).to eq("Subscription cancelled!")
  end

  it 'if customer or subscription cannot be found, sends an unsuccessful response' do
    update_params = { customer_id: @customer1.id, subscription_id: 100 }
    patch api_v0_unsubscribe_path, params: update_params

    expect(response).to_not be_successful
    expect(response.status).to eq(404)
    
    response_data = JSON.parse(response.body, symbolize_names: true)

    expect(response_data).to have_key(:message)
    expect(response_data[:message]).to be_a String
    expect(response_data[:message]).to eq("Customer or Subscription could not be found.")
  end
end