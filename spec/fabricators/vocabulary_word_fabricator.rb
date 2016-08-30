Fabricator(:vocabulary_word) do
  main { Faker::Lorem.word }
  chinese { %w(一 二 三 四 五 六 七 八 九 十 十一你 十二 十三 十四 十五).sample }
  part_of_speech { Faker::Lorem.word }
  ipa { Faker::Lorem.word }
  sentence { Faker::Lorem.sentence }
  definition { Faker::Lorem.sentence }
end