require "spec_helper"

describe Quiz do

  describe "#total_points_possible" do
    let(:quiz) { Fabricate(:quiz) }

    it "should return 0 if there are no questions for the quiz" do
      expect(quiz.total_points_possible).to eq(0)
    end

    it "should return an integer greater than 1 if the quiz has questions" do
      question_1 = Fabricate(:question, quiz_id: quiz.id)
      question_2 = Fabricate(:question, quiz_id: quiz.id)
      question_3 = Fabricate(:question, quiz_id: quiz.id)

      points = [question_1.value, question_2.value, question_3.value].inject(:+)

      expect(quiz.total_points_possible).to eq(points)
    end
  end

end