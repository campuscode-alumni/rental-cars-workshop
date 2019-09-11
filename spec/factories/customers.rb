FactoryBot.define do
  factory :personal_customer do
    name { 'Jose Silva' }
    sequence(:email) { |n| "email#{n}@email.com" }
    cpf { Faker::IDNumber.brazilian_citizen_number(formatted: true) }
    phone { '11 999990000' }
  end
  factory :company_customer do
    name { 'ACME Inc' }
    fantasy_name { 'ACME Inc' }
    sequence(:email) { |n| "email#{n}@email.com" }
    cnpj { '99509276000167' }
    phone { '11 99990000' }
  end
end
