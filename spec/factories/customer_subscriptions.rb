FactoryBot.define do
  factory :customer_subscription do
    customer
    subscription
    status { rand(0..1) }
    frequency { rand(0..4) }
  end
end
