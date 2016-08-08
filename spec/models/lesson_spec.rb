require "spec_helper"

describe Lesson do
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

end