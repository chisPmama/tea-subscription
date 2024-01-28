require "rails_helper"

RSpec.describe "Customer Subscription" do
  before(:each) do
    customer_data
    subscription_data
    post_params = { customer_id: @customer1.id, subscription_id: @subscription1.id }

    post api_v0_subscribe_path, params: post_params
  end

  it 'gives a successful response' do
    expect(response).to be_successful
      
    expect(response.status).to eq(201)
    binding.pry
    expect(@response_body).to be_a Hash
  end
end