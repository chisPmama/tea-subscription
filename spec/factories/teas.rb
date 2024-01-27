FactoryBot.define do
  factory :tea do
    title { Faker::Tea.variety }
    description { Faker::Tea.type }
    temperature { Faker::Number.between(from: 70.0, to: 100.0).round(1) }
    brew_time { Faker::Number.between(from: 1, to: 5) }
  end
end