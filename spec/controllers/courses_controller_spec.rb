require "rails_helper"

describe CoursesController do

  describe "GET show" do
    let!(:course) { Fabricate(:course) }
    let!(:lesson_1) { Fabricate(:lesson, course_id: course.id, published: true) }
    let!(:lesson_2) { Fabricate(:lesson, course_id: course.id, published: true) }
    let!(:lesson_3) { Fabricate(:lesson, course_id: course.id) }

    context "with paid member logged in" do
      before do
        sign_in_paid_member
      end

      it "only shows the published lessons" do
        get :show, id: course.slug
        expect(assigns(:course).published_lessons).not_to include(lesson_3)
      end
    end

    context "not logged in" do
      it "should redirect to the log in page" do
        get :show, id: course.slug
        expect(response).to redirect_to(sign_in_path)
      end
    end

    context "free user logged in" do
      it "it should redirect to the upgrade page" do
        set_current_user
        get :show, id: course.slug
        expect(response).to redirect_to(upgrade_path)
      end
    end
  end

  describe "GET index" do
    let!(:published_course) { Fabricate(:course, published: true) }
    let!(:unpublished_course) { Fabricate(:course) }

    context "logged in paid user" do
      it "should show only the published courses" do
        get :index
        expect(assigns(:courses)).to match_array([published_course])
      end
    end
  end

end
