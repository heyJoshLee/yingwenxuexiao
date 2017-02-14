require "spec_helper"

describe Lesson do

  it { should belong_to(:course) }
  it { should validate_presence_of(:lesson_number)}
  it { should validate_numericality_of(:lesson_number).only_integer}
  it { should have_many(:vocabulary_words)}
  it { should belong_to(:unit) }


  describe "#has_quiz?" do
    let(:lesson ) { Fabricate(:lesson) }
    it "should return false if the lesson doesn't have a quiz" do
      expect(lesson.has_quiz?).to be_falsey
    end
    it "should return true if the lesson has a quiz" do
      quiz =  Fabricate(:quiz, lesson_id: lesson.id)
      expect(lesson.has_quiz?).to be_truthy
    end
  end

  describe "#create" do
    let!(:lesson) {Fabricate(:lesson) }

    it "Should create a new unit and assign the lesson to that unit if not assigned a unit" do
      expect(lesson.course.units.count).to eq(1)
    end
  end

  describe "#add_vocabulary_word(vocabulary_word.id)" do

    let!(:lesson) { Fabricate(:lesson) }
    let!(:vocabulary_word) { Fabricate(:vocabulary_word) }
    let!(:vocabulary_word_2) { Fabricate(:vocabulary_word) }

    it "should include the vocabulary_word" do
      lesson.add_vocabulary_word(vocabulary_word)
      expect(lesson.vocabulary_words).to include(vocabulary_word)
    end

    it "should add one to the total count of vocabulary words" do
      lesson.add_vocabulary_word(vocabulary_word)
      expect(lesson.vocabulary_words.count).to eq(1)
    end

    it "should include two vocabulary words if two words are added" do
      lesson.add_vocabulary_word(vocabulary_word)
      lesson.add_vocabulary_word(vocabulary_word_2)
      expect(lesson.vocabulary_words.count).to eq(2)
      expect(lesson.vocabulary_words).to include(vocabulary_word)
      expect(lesson.vocabulary_words).to include(vocabulary_word_2)
    end

    it "should not change anything if the lesson already contains the vocabulary word" do
      lesson.add_vocabulary_word(vocabulary_word)
      lesson.add_vocabulary_word(vocabulary_word)
      
      expect(lesson.vocabulary_words).to include(vocabulary_word)
      expect(lesson.vocabulary_words.count).to eq(1)
    end
  end


  describe "#remove_vocabulary_word(vocabulary_word)" do
    let!(:lesson) { Fabricate(:lesson) }

    let!(:vocabulary_word) { Fabricate(:vocabulary_word) }

    before do
      lesson.add_vocabulary_word(vocabulary_word)
    end

    it "should remove the the vocabulary word from the lesson" do
      lesson.remove_vocabulary_word(vocabulary_word)
      expect(lesson.vocabulary_words).to_not include(:vocabulary_word)
    end

    it "does not delete the vocabulary word" do
      lesson.remove_vocabulary_word(vocabulary_word)
      expect(VocabularyWord.find(vocabulary_word.id)).to eq(vocabulary_word)
    end

    it "doesn't delete other vocabulary words" do
      vocabulary_word_2 = Fabricate(:vocabulary_word)
      lesson.add_vocabulary_word(vocabulary_word_2)
      lesson.remove_vocabulary_word(vocabulary_word)
      expect(lesson.vocabulary_words).to eq([vocabulary_word_2])
    end

  end

  describe "using correct db" do
    it "connects to the correct database" do
      expect(ActiveRecord::Base.connection_config[:database]).to match(/test/)
    end
  end



end