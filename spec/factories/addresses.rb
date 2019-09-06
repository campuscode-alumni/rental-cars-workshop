FactoryBot.define do
  factory :address do
    street { 'MyString' }
    number { 'MyString' }
    complement { 'MyString' }
    neighborhood { 'MyString' }
    city { 'MyString' }
    state { 'MyString' }
    subsidiary { nil }
  end
end
