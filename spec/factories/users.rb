FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    password { '12345678' }
    subsidiary
    role { :employee }

    trait :manager do
      role { :manager }
    end

    trait :admin do
      role { :admin }
    end
  end
end
