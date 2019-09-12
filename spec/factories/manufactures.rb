FactoryBot.define do
  factory :manufacture do
    sequence(:name) { |n| "Fiat #{n}"}
  end
end
