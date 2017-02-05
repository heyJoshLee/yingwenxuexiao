require "spec_helper"

describe VocabularyWord do
  it { should validate_presence_of(:main) }
  it { should validate_presence_of(:chinese) }
  it { should validate_presence_of(:part_of_speech) }
  it { should validate_presence_of(:ipa) }
  it { should validate_presence_of(:definition) }
  it { should validate_presence_of(:sentence) }


  describe ".find_related_words(string)" do
    let!(:cat) { Fabricate(:vocabulary_word, main: "cat") }
    let!(:at) { Fabricate(:vocabulary_word, main: "at") }
    let!(:bat) { Fabricate(:vocabulary_word, main: "bat") }
    let!(:apple) { Fabricate(:vocabulary_word, main: "apple") }
    let!(:basket) { Fabricate(:vocabulary_word, main: "basket") }
    let!(:dog) { Fabricate(:vocabulary_word, main: "dog") }


    it "returns an empty array if no input" do
      expect(VocabularyWord.find_related_words()).to eq([])      
    end

    it "returns empty array with an empty string" do
      expect(VocabularyWord.find_related_words("")).to eq([])
    end

    it "returns matches with one match" do
      expect(VocabularyWord.find_related_words("apple")).to eq([apple])
    end

    it "returns matches with two matches" do
      expect(VocabularyWord.find_related_words("ba")).to match_array([bat, basket])
    end

    it "returns matches with three matches" do
      expect(VocabularyWord.find_related_words("at")).to match_array([cat, at, bat]) 
    end

  end
end