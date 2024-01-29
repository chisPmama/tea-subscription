require "rails_helper"

RSpec.describe "Customer Subscriptions List" do
  before(:each) do
    customer_data
    create(:subscription, customer: @customer1, status: "active")
    create(:subscription, customer: @customer1, status: "active")
    create(:subscription, customer: @customer1, status: "cancelled")
  end
  
  it 'gives a successful response' do
    get_param = { customer_id: @customer1.id }
    get api_v0_subscriptions_path, params: get_param

    expect(response).to be_successful
      
    expect(response.status).to eq(200)
    expect(@customer1.subscriptions.count).to eq(3)

    response_data = JSON.parse(response.body, symbolize_names: true)[:data]
    expect(response_data).to be_an Array
    
    active = @customer1.subscriptions.where("status = 'active'")
    active_sub = response_data.find_all{|subscription| subscription[:attributes][:status] == "active"}
    expect(active_sub.count).to eq(active.count)

    cancelled = @customer1.subscriptions.where("status = 'cancelled'")
    cancelled_sub = response_data.find_all{|subscription| subscription[:attributes][:status] == "cancelled"}
    expect(cancelled_sub.count).to eq(cancelled.count)

    subscription = response_data.first[:attributes]

    expect(subscription).to have_key(:title)
    expect(subscription[:title]).to be_a String

    expect(subscription).to have_key(:price)
    expect(subscription[:price]).to be_a Float

    expect(subscription).to have_key(:status)
    expect(subscription[:status]).to be_a String

    expect(subscription).to have_key(:frequency)
    expect(subscription[:frequency]).to be_a String
  end

  it 'if customer does not have subscriptions, send a unique response' do
    get_param = { customer_id: @customer2.id }
    get api_v0_subscriptions_path, params: get_param

    expect(response).to_not be_successful
    
    expect(response.status).to eq(404)
    expect(@customer2.subscriptions.count).to eq(0)

    response_data = JSON.parse(response.body, symbolize_names: true)

    expect(response_data).to have_key(:message)
    expect(response_data[:message]).to be_a String
    expect(response_data[:message]).to eq("This customer does not have any subscriptions.")
  end

  it 'if customer or subscription cannot be found, sends an unsuccessful response' do
    get_param = { customer_id: 300 }
    get api_v0_subscriptions_path, params: get_param

    expect(response).to_not be_successful
      
    expect(response.status).to eq(404)
    expect(@customer1.subscriptions.count).to eq(3)

    response_data = JSON.parse(response.body, symbolize_names: true)

    expect(response_data).to have_key(:message)
    expect(response_data[:message]).to be_a String
    expect(response_data[:message]).to eq("Customer or Subscription could not be found.")
  end
end