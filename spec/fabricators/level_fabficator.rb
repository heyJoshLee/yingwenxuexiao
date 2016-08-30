Fabricator(:level) do
  points { (1..1000).to_a.sample }
  number { (1..100).to_a.sample }
  message { Faker::Lorem.paragraph}
end