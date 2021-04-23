# ログインユーザ
User.create!(
  [
    {
      username: 'ゲスト',
      email: 'guest@example.com',
      password: "foobar",
      password_confirmation: "foobar",
      profile: "ゲストユーザーです！",
      favorite_game: "カタン",
      img: open("#{Rails.root}/db/fixtures/user/sample0.jpg"),
      confirmed_at: Time.current,
    },
    {
      username: "foobar",
      email: "foobar@mail",
      password: "foobar",
      password_confirmation: "foobar",
      profile: "こんにちはfoobarです！\r\n色々やってます！",
      favorite_game: "ドミニオン",
      img: open("#{Rails.root}/db/fixtures/user/sample1.jpg"),
      confirmed_at: Time.current,
    },
    {
      username: "other",
      email: "other@mail",
      password: "foobar",
      password_confirmation: "foobar",
      profile: "こんにちはotherです！\r\n色々やってます！",
      favorite_game: "ドミニオン",
      img: open("#{Rails.root}/db/fixtures/user/sample2.jpg"),
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
    confirmed_at: Time.current,
  )
end

FileUtils.rm_rf("#{Rails.root}/public/uploads/event")
# イベント
start_time_1 = DateTime.current.since(3.month).beginning_of_day.since(13.hours)
start_time_2 = DateTime.current.since(2.month).beginning_of_day.since(15.hours)
start_time_3 = DateTime.current.since(2.month).beginning_of_day.since(10.hours)
Event.create!(
  [
    {
      name: "ゲーム大会を名古屋で開催します",
      text: "名古屋内でボードゲームをプレイする方を募集しています！

初心者歓迎！、むしろそういう人に参加してほしいイベントです。

今回の企画は、【ゲーム数3本以上を予定】予定しています！

初めてプレイすること方も多いのでどんどんご気軽にご応募ください。
なお、遊ぶゲームはコメント欄で決める予定です",
      start_time: start_time_1,
      ending_time: start_time_1.since(3.hours),
      participant_limit: "4",
      tag_list: "ゲーム未定,名古屋初心者歓迎",
      user_id: "1",
      img: open("#{Rails.root}/db/fixtures/sample10.jpg"),
      place: 'ボードゲームバー ロードオブアギト',
      address: '愛知県 名古屋市 名古屋駅',
    },
    {
      name: "【第7回】秋葉原ドミニオン大会",
      text: "東京都内でドミニオンをプレイする方を募集しています。

司会進行は主催者が努めます。

参加人数は8人でトーナメントを予定していますが、
希望者の人数次第では増やすため12人までは参加できるようにしています。

開催場所は参加人数が確定でき次第、決める予定です。

その他、ご質問等あればコメント欄にてお願いいたします。",
      start_time: start_time_2,
      ending_time: start_time_2.since(3.hours),
      participant_limit: "5",
      tag_list: "ドミニオン,東京,秋葉原,ボードゲームバー",
      user_id: "2",
      img: open("#{Rails.root}/db/fixtures/sample1.jpg"),
      place: 'ボードゲームバー(未定)',
      address: '東京都 千代田区 秋葉原',
    },
    {
      name: "学生交流会",
      text: "学生同士でボードゲームで遊んじゃいましょう!
3人以上で20分かからないくらいの簡単なボードゲームを5種類ほどご用意します。
詳しくは本文最下部をご確認ください。

【参加者】学生のみ
【参加費】あり(500円)

ソフトドリンクやおやつは用意しています。

お友達作りはオッケーですが、営業や勧誘はご遠慮下さい！！

私たちで説明、進行をいたしますので、わからないことはお気軽にコメント欄で質問してください。
      ",
      start_time: start_time_3,
      ending_time: start_time_3.since(5.hours),
      participant_limit: "5",
      tag_list: "犯人は踊る,文京区",
      user_id: "3",
      img: open("#{Rails.root}/db/fixtures/sample9.jpg"),
      place: '愛知県名古屋市中村区名駅2-42-10',
      address: 'レンタルスペース',
    },
  ]
)

name = [
  'カルカソンヌ', 'ドミニオン', 'ゴキブリポーカー',
  'ニムト', 'バトルライン', 'パンデミック', 'ブロックス', 'ラブレター',
  'ワンナイト人狼', '犯人は踊る', '宝石の輝き',
]

comment = ['ご質問はこちらにお願いします。', 'また、他に遊びたいゲーム等あればリクエストしてください！']

prefectures = [
  '愛知県', '愛知県', '東京都', '東京都', '大阪府', '大阪府',
  '福岡県', '北海道', '東京都', '東京都', '愛知県',
]

address = [
  '愛知県名古屋市中区大須３丁目３８−１３ 喜久屋大須ビル',
  '愛知県名古屋市中区大須３丁目１８−８ 赤門ビル2階',
  '東京都千代田区岩本町１丁目４−５',
  '東京都千代田区外神田３丁目８−５',
  '大阪府大阪市北区堂山町５−１４',
  '大阪府大阪市阿倍野区阪南町１丁目５３−２０',
  '福岡県福岡市博多区祇園町４−６ 平田ビル 401号',
  '北海道札幌市中央区南１条東２丁目1ｰ3 和興ビル',
  '東京都新宿区西新宿7-19-6',
  '東京都墨田区京島1-27-16',
  '愛知県名古屋市中村区名駅2-42-10',
]

place = [
  '大須ボードゲームカフェ ボードボード',
  'JELLY JELLY CAFE',
  '東京ボードゲームバー',
  'ゲームカフェ秋葉原集会所',
  'ボードゲームカフェ ピエット',
  'ボードゲームカフェ-デザート',
  'ボードゲームカフェ福岡博多フレンズフレンズ',
  'ボードゲームプレイスペース フレンズ',
  'レンタルスペース',
  'レンタルスペース',
  'レンタルスペース',
]

20.times do |n|
  participant_limit = rand(2..10)
  user_id = rand(7..User.count)
  event_id = Event.count + 1
  start_time = DateTime.current.beginning_of_day.since(13.hours) + rand(-3..5).hours + rand(1..100).days
  ending_time = start_time.since(rand(2..5).hours)
  image = open("#{Rails.root}/db/fixtures/sample#{n % 11}.jpg")
  Event.create!(
    name: "#{prefectures[n % 11]}の方、一緒に#{name[n % 11]}を遊びましょう!",
    text: "#{prefectures[n % 11]}の方、一緒に#{name[n % 11]}を遊びましょう!
主催者もプロフェッショナルでは無く、初心者や初めての方とも一緒に遊べたらと思っています！

他にもやってみたいゲームがあればご持参ください。

参加費は一人1000円を予定しています。

ソフトドリンクやおやつは用意しています。

お友達作りはオッケーですが、営業や勧誘はご遠慮下さい！！

わからないことはお気軽にコメント欄で質問してください。",
    start_time: start_time,
    ending_time: ending_time,
    participant_limit: participant_limit,
    tag_list: "#{name[n % 11]},#{prefectures[n % 11]}",
    user_id: user_id,
    created_at: DateTime.current.since(n.seconds),
    img: image,
    place: place[n % 11],
    address: address[n % 11]
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

# イベント参加
(4..8).each do |n|
  Participation.create!(user_id: 1, event_id: n)
end

(2..6).each do |n|
  Participation.create!(user_id: n, event_id: 2)
end

(2..5).each do |n|
  Participation.create!(user_id: n, event_id: 3)
end

# フォロワー
(1..7).each do |n|
  (1..10).each do |m|
    User.find(n).active_relationships.create(followed_id: m)
  end
end

User.create!(
  [
    {
      username: 'admin',
      email: 'admin@example.com',
      password: ENV['ADMIIN_USER_PASSWORD'],
      password_confirmation: ENV['ADMIIN_USER_PASSWORD'],
      profile: "管理人です。",
      favorite_game: "カタン",
      img: open("#{Rails.root}/db/fixtures/user/sample0.jpg"),
      confirmed_at: Time.current,
      admin: TRUE,
    },
  ]
)
