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
    expect(@subscription1.subscription_teas.count).to eq(1)

    response_data = JSON.parse(response.body, symbolize_names: true)

    expect(response_data).to have_key(:message)
    expect(response_data[:message]).to be_a String
    expect(response_data[:message]).to eq("Subscription added!")
  end

  it 'if tea is already subscribed, sends an unsuccessful response' do
    SubscriptionTea.create(subscription_id: @subscription1.id, tea_id: @tea1.id)
    post_params = { subscription_id: @subscription1.id, tea_id: @tea1.id }
    post api_v0_subscribe_tea_path, params: post_params

    expect(response).to_not be_successful
    expect(response.status).to eq(422)

    response_data = JSON.parse(response.body, symbolize_names: true)

    expect(response_data).to have_key(:message)
    expect(response_data[:message]).to be_a String
    expect(response_data[:message]).to eq("Subscription already exists.")
  end
end