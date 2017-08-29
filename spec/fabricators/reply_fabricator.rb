Fabricator(:reply) do
  body { Faker::Lorem.paragraph }
  author { Fabricate(:user) }
end



