FactoryBot.define do
  factory :event do
    association :user
    sequence(:name) { |n| "トランプやろう#{n}" }
    sequence(:text) { |n| "トランプをプレイする人を募集！#{n}" }
    start_time { DateTime.current.since(1.hours) }
    ending_time { DateTime.current.since(3.hours) }
    participant_limit { 4 }
    tag_list { "トランプ,東京" }

    trait :invalid do
      name nil
    end
  end
end
