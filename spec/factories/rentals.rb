FactoryBot.define do
  factory :rental do
    car
    user
    customer { nil }
  end
end
