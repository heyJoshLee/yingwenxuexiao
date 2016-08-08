Fabricator(:choice) do 
  question_id { 1 }
  correct { false }
  body { Faker::Lorem.paragraph}

end