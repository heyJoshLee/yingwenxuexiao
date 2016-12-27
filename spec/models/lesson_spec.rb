require "spec_helper"

describe Lesson do

  it { should belong_to(:course) }
  it { should validate_presence_of(:lesson_number)}
  it { should validate_numericality_of(:lesson_number).only_integer}

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

  describe "using correct db" do
    it "connects to the correct database" do
      expect(ActiveRecord::Base.connection_config[:database]).to match(/test/)
    end
  end



end