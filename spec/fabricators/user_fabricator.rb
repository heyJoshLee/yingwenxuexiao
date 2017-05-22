Fabricator(:user) do
  name { Faker::Name.name }
  email { Faker::Internet.email }
  password { Faker::Internet.password }
  membership_level "free"
  stripeid "cus_AVUti38AGlyyVv"
end
