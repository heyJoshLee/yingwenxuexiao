Fabricator(:question) do
  body { Faker::Lorem.paragraph }
  quiz_id { 1 }
  value { (10...100).to_a.sample }
end