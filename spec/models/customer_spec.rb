require 'rails_helper'

RSpec.describe Customer, type: :model do
  describe "relationships" do
    it { should have_one :subscription }
    it { should have_many :customer_teas }
    it { should have_many(:teas).through(:customer_teas) }
  end

  describe "validations" do
    it { should validate_presence_of(:first_name) }
    it { should validate_presence_of(:last_name) }
    it { should validate_presence_of(:email) }
    it { should validate_presence_of(:address) }
  end

  describe 'customer data' do
    it 'exists' do
      customer_data
      expect(Customer.all.count).to eq(3)
    end
  end
end