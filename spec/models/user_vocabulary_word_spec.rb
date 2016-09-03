require "spec_helper"

describe UserVocabularyWord do

  describe "#choices(type)" do
    let(:user) { Fabricate(:user) }
    let(:vocabulary_word_1) { Fabricate(:vocabulary_word, main: "that", chinese: "你好", definition: "a word used as a greeting") }
    let(:vocabulary_word_2) { Fabricate(:vocabulary_word) }
    let(:vocabulary_word_3) { Fabricate(:vocabulary_word) }
    let(:vocabulary_word_4) { Fabricate(:vocabulary_word) }

    before do
      user.add_vocabulary_word(vocabulary_word_1)
      user.add_vocabulary_word(vocabulary_word_2)
      user.add_vocabulary_word(vocabulary_word_3)
      user.add_vocabulary_word(vocabulary_word_4)
    end

    context ":english_to_chinese" do
      it "returns an array of four strings" do
        expect(user.user_vocabulary_words.first.choices(:english_to_chinese).count).to eq(4)
      end

      it "returns an array that contains the correct english word" do
        expect(user.user_vocabulary_words.first.choices(:english_to_chinese)).to include(vocabulary_word_1.chinese)
      end

      it "returns an array that contains the correct english word" do
        expect(user.user_vocabulary_words.first.choices(:english_to_chinese)).to include(vocabulary_word_1.chinese)
      end

      it "returns four different choices" do
        expect(user.user_vocabulary_words.first.choices(:english_to_chinese)).to include(vocabulary_word_1.chinese)
        expect(user.user_vocabulary_words.first.choices(:english_to_chinese)).to include(vocabulary_word_2.chinese)
        expect(user.user_vocabulary_words.first.choices(:english_to_chinese)).to include(vocabulary_word_3.chinese)
        expect(user.user_vocabulary_words.first.choices(:english_to_chinese)).to include(vocabulary_word_4.chinese)
      end
    end

    context ":chinese_to_english" do
      it "returns an array of four strings" do
        expect(user.user_vocabulary_words.first.choices(:chinese_to_english).count).to eq(4)
      end

      it "returns an array that contains the correct chinese word" do
        expect(user.user_vocabulary_words.first.choices(:chinese_to_english)).to include(vocabulary_word_1.main)
      end

      it "returns an array with four different choices" do
        expect(user.user_vocabulary_words.first.choices(:chinese_to_english)).to include(vocabulary_word_1.main)
        expect(user.user_vocabulary_words.first.choices(:chinese_to_english)).to include(vocabulary_word_2.main)
        expect(user.user_vocabulary_words.first.choices(:chinese_to_english)).to include(vocabulary_word_3.main)
        expect(user.user_vocabulary_words.first.choices(:chinese_to_english)).to include(vocabulary_word_4.main)
      end
    end

    context ":definition" do
      it "returns an array of four strings" do
        expect(user.user_vocabulary_words.first.choices(:definition).count).to eq(4)
      end

      it "returns an array that contains the correct definition" do
        expect(user.user_vocabulary_words.first.choices(:definition)).to include(vocabulary_word_1.definition)
      end

      it "returns an array of four different choices" do
        expect(user.user_vocabulary_words.first.choices(:definition)).to include(vocabulary_word_1.definition)
        expect(user.user_vocabulary_words.first.choices(:definition)).to include(vocabulary_word_2.definition)
        expect(user.user_vocabulary_words.first.choices(:definition)).to include(vocabulary_word_3.definition)
        expect(user.user_vocabulary_words.first.choices(:definition)).to include(vocabulary_word_4.definition)
      end
    end

    context ":spelling" do
      it "returns an array of four strings" do
        skip
        expect(user.user_vocabulary_words.first.choices(:spelling).count).to eq(4)
      end

      it "returns an array that contains the correct spelling" do
        skip
        expect(user.user_vocabulary_words.first.choices(:spelling)).to include(vocabulary_word_1.main)
      end

    end
  end

end