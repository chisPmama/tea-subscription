require "rails_helper"

RSpec.describe "Add Tea Subscription" do
  before(:each) do
    customer_data
    subscription_data
    create(:subscription, customer: @customer1, status: "active")

    tea_data
  end
  
  it 'gives a successful response' do
    post_params = { subscription_id: @subscription1.id, tea_id: @tea1.id }
    post api_v0_subscribe_tea_path, params: post_params

    expect(response).to be_successful
      
    expect(response.status).to eq(201)

    binding.pry

    subscription = @customer1.subscriptions.first
    expect(subscription.status).to eq("active")

    response_data = JSON.parse(response.body, symbolize_names: true)

    expect(response_data).to have_key(:message)
    expect(response_data[:message]).to be_a String
    expect(response_data[:message]).to eq("Subscription added!")
  end

  xit 'if customer or subscription cannot be found, sends an unsuccessful response' do
    post_params = { customer_id: @customer1.id, subscription_id: 100 }
    post api_v0_subscribe_path, params: post_params

    expect(response).to_not be_successful
      
    expect(response.status).to eq(404)
    expect(@customer1.subscriptions.count).to eq(0)

    response_data = JSON.parse(response.body, symbolize_names: true)

    expect(response_data).to have_key(:message)
    expect(response_data[:message]).to be_a String
    expect(response_data[:message]).to eq("Customer or Subscription could not be found.")
  end
end