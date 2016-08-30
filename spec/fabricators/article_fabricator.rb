Fabricator(:article) do 
  title { Faker::Lorem.sentence }
  main_image_url { Faker::Internet.url }
  user_id { (1..100).to_a.sample }
  category_id { (1..100).to_a.sample }
  body { Faker::Lorem.paragraph }
end