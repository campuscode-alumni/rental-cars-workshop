FactoryBot.define do
  factory :personal_customer do
    name { 'Jose Silva' }
    email { 'jose@gmail.com' }
    cpf { '02471466095' }
    phone { '11 999990000' }
  end
  factory :company_customer do
    name { 'ACME Inc' }
    fantasy_name { 'ACME Inc' }
    email { 'acme@gmail.com' }
    cnpj { '99509276000167' }
    phone { '11 99990000' }
  end
end
