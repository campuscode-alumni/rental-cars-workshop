FactoryBot.define do
  factory :inspection do
    fuel_level { 1 }
    cleanance_level { 1 }
    damages { 'MyText' }
    car { nil }
    user { nil }
  end
end
