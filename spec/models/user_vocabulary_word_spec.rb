require "spec_helper"

describe UserVocabularyWord do

  describe "#choices(type)" do
    let(:user) { Fabricate(:user) }
    let(:vocabulary_word_1) { Fabricate(:vocabulary_word, main: "hi", chinese: "你好", definition: "a word used as a greeting") }

    before do
      user.add_vocabulary_word(vocabulary_word_1)
    end

    context ":english" do
      it "returns an array of four strings" do
        expect(user.user_vocabulary_words.first.choices(:english).count).to eq(4)
      end

      it "returns an array that contains the correct english word" do
        expect(user.user_vocabulary_words.first.choices(:english)).to include(vocabulary_word_1.main)
      end
    end

    context ":chinese" do
      it "returns an array of four strings" do
        expect(user.user_vocabulary_words.first.choices(:chinese).count).to eq(4)
      end

      it "returns an array that contains the correct chinese word" do
        expect(user.user_vocabulary_words.first.choices(:chinese)).to include(vocabulary_word_1.chinese)
      end
    end

    context ":definition" do
      it "returns an array of four strings" do
        expect(user.user_vocabulary_words.first.choices(:definition).count).to eq(4)
      end

      it "returns an array that contains the correct definition" do
        expect(user.user_vocabulary_words.first.choices(:definition)).to include(vocabulary_word_1.definition)
      end
    end

    context ":spelling" do
      it "returns an array of four strings" do
        expect(user.user_vocabulary_words.first.choices(:spelling).count).to eq(4)
      end

      it "returns an array that contains the correct spelling" do
        expect(user.user_vocabulary_words.first.choices(:spelling)).to include(vocabulary_word_1.main)
      end
    end
  end

end