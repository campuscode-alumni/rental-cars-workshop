FactoryBot.define do
  factory :rental do
    car
    user
    customer { nil }
    scheduled_start { 1.day.from_now }
    scheduled_end { 5.days.from_now }
    started_at { 1.days.from_now }
    status { :active }

    trait :finished do
      status { :finished }
      scheduled_start { 5.days.ago }
      scheduled_end { 1.day.ago }
      finished_at { 1.days.ago }
    end

    trait :scheduled do
      status { :scheduled }
    end

    factory :scheduled_rental, traits: [:scheduled]
    factory :finished_rental, traits: [:finished]
  end
end
