FactoryBot.define do
  factory :subscription do
    title { Faker::Superhero.name }
    price { rand(1..100) }
  end
end
