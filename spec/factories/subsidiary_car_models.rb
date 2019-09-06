FactoryBot.define do
  factory :subsidiary_car_model do
    price { 10 }
    subsidiary { nil }
    car_model { nil }
  end
end
