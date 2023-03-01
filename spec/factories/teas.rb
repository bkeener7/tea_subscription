FactoryBot.define do
  factory :tea do
    title { Faker::Tea.variety }
    description { Faker::Tea.type }
    temperature { rand(1..100) }
    brew_time { rand(0..100) }
  end
end
