Fabricator(:affiliate) do
  name { Faker::Lorem.name }
  contact_email { Faker::Internet.email}
  contact_name { Faker::Lorem.name }
  domain { Faker::Internet.email }
  notes { Faker::Lorem.paragraph }
end



