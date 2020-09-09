20.times do
  Event.create(
    name: Faker::Internet.username,
    text: Faker::Lorem.paragraph(sentence_count = 3)
  )
end
