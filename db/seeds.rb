# ログインユーザ
User.create!(
  id: "1",
  username: "foobar",
  email: "foobar@mail",
  password: "foobar",
  password_confirmation: "foobar",
  confirmed_at: Time.now
)

# その他ユーザ
20.times do |n|
  user_name = Faker::Internet.user_name
  email = Faker::Internet.email
  password = "password"
  User.create!(
    username: user_name,
    email: email,
    password: password,
    password_confirmation: password,
    confirmed_at: Time.now
  )
end

# イベント
start_time = DateTime.current.tomorrow
Event.create!(
  [
    {
      name: "ドミニオンやりたい",
      text: "みんなで色々ゲームしよう！",
      start_time: DateTime.current.tomorrow,
      ending_time: start_time.since(3.hours),
      participant_limit: "4",
      tag_list: "ドミニオン,名古屋",
      user_id: "1",
    },
    {
      name: "ゲーマー",
      text: "東京住みの人募集、ゲームやりましょう",
      start_time: DateTime.current.tomorrow,
      ending_time: start_time.since(3.hours),
      participant_limit: "5",
      tag_list: "トランプ,東京",
      user_id: "2",
    },
    {
      name: "人生ゲーム好きのためのオフ会",
      text: "人生ゲーム好きのためのオフ会です。人数5人まで！",
      start_time: DateTime.current.tomorrow,
      ending_time: start_time.since(3.hours),
      participant_limit: "5",
      tag_list: "人生ゲーム,千代田区",
      user_id: "3",
    },
  ]
)

50.times do |n|
  name = Faker::Game.title
  state = Faker::Address.state
  participant_limit = rand(2..10)
  user_id = rand(2..User.count)
  Event.create!(
    name: "#{name}やろう!",
    text: "#{state}の#{name}好き集まれ!",
    start_time: DateTime.current.tomorrow,
    ending_time: start_time.since(3.hours),
    participant_limit: participant_limit,
    tag_list: "#{name},#{state}",
    user_id: user_id,
  )
end

# 参加者
(4..20).each do |i|
  Participation.create!(user_id: 1, event_id: i)
end

(2..6).each do |i|
  Participation.create!(user_id: i, event_id: 2)
end

(2..5).each do |i|
  Participation.create!(user_id: i, event_id: 3)
end
