Fabricator(:level) do
  points { (1..1000).to_a.sample }
  number { 1 }
  message { Faker::Lorem.paragraph}
end