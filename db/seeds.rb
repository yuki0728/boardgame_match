# ログインユーザ
User.create!(
  [
    {
      username: "foobar",
      email: "foobar@mail",
      password: "foobar",
      password_confirmation: "foobar",
      profile: "こんにちはfoobarです！\r\n色々やってます！",
      favorite_game: "ドミニオン",
      img: open("#{Rails.root}/db/fixtures/user/sample0.jpg"),
      confirmed_at: Time.current,
    },
    {
      username: "other",
      email: "other@mail",
      password: "foobar",
      password_confirmation: "foobar",
      profile: "こんにちはotherです！\r\n色々やってます！",
      favorite_game: "ドミニオン",
      img: open("#{Rails.root}/db/fixtures/user/sample1.jpg"),
      confirmed_at: Time.current,
    },
  ]
)

# その他ユーザ
20.times do |n|
  user_name = Faker::Internet.user_name
  profile = "こんにちは#{user_name}です！\r\nボードゲームを愛しています。\r\nよろしくね。"
  email = Faker::Internet.email
  password = "password"
  image = open("#{Rails.root}/db/fixtures/user/sample#{n % 6}.jpg")
  User.create!(
    username: user_name,
    email: email,
    password: password,
    password_confirmation: password,
    profile: profile,
    favorite_game: "人生ゲーム",
    img: image,
    confirmed_at: Time.current
  )
end

FileUtils.rm_rf("#{Rails.root}/public/uploads/event")
# イベント
start_time = DateTime.current.tomorrow
Event.create!(
  [
    {
      name: "ドミニオンの大会を名古屋で開催します",
      text: "みんなで色々ゲームしよう！",
      start_time: DateTime.current.tomorrow,
      ending_time: start_time.since(3.hours),
      participant_limit: "4",
      tag_list: "ドミニオン,名古屋",
      user_id: "1",
      img: open("#{Rails.root}/db/fixtures/sample1.jpg"),
    },
    {
      name: "ゲーマー",
      text: "東京住みの人募集、ゲームやりましょう",
      start_time: DateTime.current.tomorrow,
      ending_time: start_time.since(3.hours),
      participant_limit: "5",
      tag_list: "宝石の輝き,東京",
      user_id: "2",
      img: open("#{Rails.root}/db/fixtures/sample10.jpg"),
    },
    {
      name: "犯人は踊るオフ会(他ゲームもやるかも)",
      text: "参加人数5人まで！千代田区〜駅集合！",
      start_time: DateTime.current.tomorrow,
      ending_time: start_time.since(3.hours),
      participant_limit: "5",
      tag_list: "犯人は踊る,千代田区",
      user_id: "3",
      img: open("#{Rails.root}/db/fixtures/sample9.jpg"),
    },
  ]
)

name = ['カルカソンヌ', 'ドミニオン', 'ゴキブリポーカー',
        'ニムト', 'バトルライン', 'パンデミック', 'ブロックス', 'ラブレター',
        'ワンナイト人狼', '犯人は踊る', '宝石の輝き']

comment = ['はじめまして', '誰かいますか？', 'おーい']

50.times do |n|
  state = Faker::Address.state
  participant_limit = rand(2..10)
  user_id = rand(7..User.count)
  event_id = Event.count + 1
  start_time = DateTime.current.tomorrow + rand(1..100).hours
  image = open("#{Rails.root}/db/fixtures/sample#{n % 11}.jpg")
  Event.create!(
    name: "#{name[n % 11]}やろう!",
    text: "#{state}の#{name[n % 11]}好き集まれ!",
    start_time: start_time,
    ending_time: start_time.since(3.hours),
    participant_limit: participant_limit,
    tag_list: "#{name[n % 11]},#{state}",
    user_id: user_id,
    created_at: DateTime.current.since(n.seconds),
    img: image,
  )

  3.times do |m|
    Comment.create(
      user_id: user_id,
      event_id: event_id,
      created_at: DateTime.current.since(m.seconds),
      content: "#{comment[m]}"
    )
  end
  Participation.create!(user_id: user_id, event_id: event_id)
end

# 参加者
Participation.create!(user_id: 1, event_id: 1)

(4..20).each do |n|
  Participation.create!(user_id: 1, event_id: n)
end

(2..6).each do |n|
  Participation.create!(user_id: n, event_id: 2)
end

(2..5).each do |n|
  Participation.create!(user_id: n, event_id: 3)
end
