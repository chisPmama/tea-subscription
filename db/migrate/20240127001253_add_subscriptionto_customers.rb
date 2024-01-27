class AddSubscriptiontoCustomers < ActiveRecord::Migration[7.0]
  def change
    add_foreign_key :subscriptions, :customers
  end
end
