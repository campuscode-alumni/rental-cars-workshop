FactoryBot.define do
  factory :car_model do
    name { Faker::Vehicle.make_and_model }
    year { '2008' }
    manufacture
    car_options { '3 portas' }
  end
end
