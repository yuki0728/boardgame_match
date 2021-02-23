FactoryBot.define do
  factory :event do
    association :user
    sequence(:name) { |n| "トランプやろう#{n}" }
    sequence(:text) { |n| "トランプをプレイする人を募集！#{n}" }
    start_time { DateTime.current.since(1.hours) }
    ending_time { DateTime.current.since(3.hours) }
    address { "東京都　秋葉原" }
    place { "ボードゲームカフェ" }
    participant_limit { 4 }
    tag_list { "トランプ,東京" }

    trait :invalid do
      name { nil }
    end

    trait :update_event do
      sequence(:name) { |n| "やっぱりドミニオンにしよう#{n}" }
      sequence(:text) { |n| "ドミニオンをプレイする人を募集！#{n}" }
    end
  end
end
