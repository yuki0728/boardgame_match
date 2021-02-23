FactoryBot.define do
  factory :user do
    username { "test_user" }
    sequence(:email) { |n| "TEST#{n}@example.com" }
    password { "testpassword" }
    profile { "test text" }
    favorite_game { "test_game" }
    img { Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec/fixtures/user_sample.jpg')) }
    confirmed_at { Time.current }
  end
end
