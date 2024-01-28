# spec/factories/subscriptions.rb
FactoryBot.define do
  factory :subscription do
    association :customer

    title { Faker::Subscription.plan }
    price { Faker::Commerce.price(range: 10.0..100.0).round(2) }
    status { nil }
    frequency { %w[monthly weekly daily].sample }
  end
end
