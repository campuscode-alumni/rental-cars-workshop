FactoryBot.define do
  factory :fine do
    issued_on { '2019-08-12' }
    demerit_points { 1 }
    fine_value { 1.5 }
    address { 'MyString' }
    car { nil }
  end
end
