FactoryBot.define do
  factory :comment do
    association :user
    association :event
    sequence(:content) { |n| "Test Comment#{n}" }
  end
end
