Fabricator(:user_vocabulary_word) do
  user_id { Fabricate(:user).id }
  vocabulary_word_id { Fabricate(:vocabulary_word).id }
end
