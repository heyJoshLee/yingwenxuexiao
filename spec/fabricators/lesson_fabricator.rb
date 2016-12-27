Fabricator(:lesson) do
  name {Faker::Lorem.sentence}
  script_english { Faker::Lorem.paragraph }
  script_chinese { Faker::Lorem.paragraph }
  video_url { Faker::Internet.url }
  notes_url { Faker::Internet.url }
  description { Faker::Lorem.paragraph }
  course_id { Fabricate(:course).id }
  slug { Faker::Lorem.word}
  lesson_number { (1..100).to_a.sample }
end
