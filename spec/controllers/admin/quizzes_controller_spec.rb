require "rails_helper"

describe Admin::QuizzesController do

  describe "DELETE destroy" do

    let!(:course) { Fabricate(:course)}
    let!(:lesson) { Fabricate(:lesson, course: course, name: "Test lesson for deleting quiz")}
    let!(:quiz) { Fabricate(:quiz, lesson: lesson)}
    let!(:question) { Fabricate(:question, quiz_id: quiz.id)}
    let!(:choice) { Fabricate(:choice, question_id: question.id)}

    context "admin logged in" do
      before do
        sign_in_admin
        delete :destroy, course_id: course.slug, lesson_id: lesson.slug, id: quiz.slug
      end

      it "destroys the quiz" do
        expect(Quiz.count).to eq(0)
      end

      it "destroys the quiz's questions" do
        expect(Question.count).to eq(0)
      end

      it "destroys the quiz's questions' choices" do
        expect(Choice.count).to eq(0)
      end

      it "redirects to the edit lesson path" do
        expect(response).to redirect_to edit_admin_course_lesson_path(course, lesson)
      end
    end
  end # admin logged in

  it_behaves_like "requires admin" do
    let!(:course) { Fabricate(:course)}
    let!(:lesson) { Fabricate(:lesson, course: course, name: "Test lesson for deleting quiz")}
    let!(:quiz) { Fabricate(:quiz, lesson: lesson)}

    let(:action) do 
      delete :destroy, course_id: course.slug, lesson_id: lesson.slug, id: quiz.slug
    end
  end

end




