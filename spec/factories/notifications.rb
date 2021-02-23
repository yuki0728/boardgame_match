FactoryBot.define do
  factory :notification do
    visiter_id { 1 }
    visited_id { 2 }
    event_id { 1 }
    action { "MyString" }
    checked { false }
  end
end
