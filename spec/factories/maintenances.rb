FactoryBot.define do
  factory :maintenance do
    car
    provider
    service_cost { Faker::Number.positive }
  end
end
