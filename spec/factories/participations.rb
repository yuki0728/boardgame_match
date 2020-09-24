FactoryBot.define do
  factory :participation do
    association :user
    association :event
    user_id { |n| n }
    event_id { |n| n }

    trait :multi_users do
      sequence(:user_id) { |n| n }
    end

    trait :multi_events do
      sequence(:event_id) { |n| n }
    end
  end
end
