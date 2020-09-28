FactoryBot.define do
  factory :user do
    username { "test" }
    sequence(:email) { |n| "TEST#{n}@example.com" }
    password { "testuser" }
    confirmed_at Time.now
  end
end
