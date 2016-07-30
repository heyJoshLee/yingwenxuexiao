Fabricator(:course) do
  name { Faker::Name.name }
  description { Faker::Lorem.paragraph }
  main_image_url { "Faker::Internet.url" }

end
