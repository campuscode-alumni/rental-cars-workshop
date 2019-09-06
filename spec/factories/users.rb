FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    password { '12345678' }
    subsidiary
  end
end
