require "spec_helper"

describe UserQuestion do

  describe "correct?" do
    let(:user) { Fabricate(:user) }
    let(:quiz) { Fabricate(:quiz) }
    let(:question) { Fabricate(:question, quiz_id: quiz.id) }

    let(:correct_choice) { Fabricate(:choice, question_id: question.id, correct: true) }
    let(:incorrect_choice) { Fabricate(:choice, question_id: question.id, correct: false) }


    it "should return false if the user answered incorrectly" do
      user.answer_question(question, incorrect_choice)
      expect(user.answered_questions.first.correct?).to be_falsey
    end

    it "should return true if the user answered correctly" do
      user.answer_question(question, correct_choice)
      expect(user.answered_questions.first.correct?).to be_truthy
    end
  end

  
end