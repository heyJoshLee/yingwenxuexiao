Fabricator(:vocabulary_word) do
  main { Faker::Lorem.word }
  chinese { Faker::Lorem.word }
  part_of_speech { Faker::Lorem.word }
  ipa { Faker::Lorem.word }
  sentence { Faker::Lorem.sentence }
  definition { Faker::Lorem.sentence }
end