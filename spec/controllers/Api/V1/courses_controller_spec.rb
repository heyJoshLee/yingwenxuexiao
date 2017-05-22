require "rails_helper"


describe Api::V1::CoursesController do

  describe "GET index" do

    let!(:course_1) { Fabricate(:course)}
    let!(:course_2) { Fabricate(:course)}
    
    context "signed in user" do
      it "should respond with JSON containing all courses" do
        set_current_user
        get :index
        expect(response.body).to eq(Course.all.to_json)
      end
    end

    context "not signed in user" do
      it "should respond with JSON containing all courses"do
        get :index
        expect(response.body).to eq(Course.all.to_json)
      end
    end
  end

  describe "GET show" do
    let!(:course_1) { Fabricate(:course) }
    let!(:lesson_1) { Fabricate(:lesson, course_id: course_1.id)}
    let!(:lesson_2) { Fabricate(:lesson, course_id: course_1.id)}
    let!(:lesson_3) { Fabricate(:lesson, course_id: course_1.id)}

    context "signed in user" do

      before do
        set_current_user
        get :show, id: course_1.slug
      end

      it "should respond with JSON containing the course information" do
        expect(response.body).to eq(course_1.to_json(:include => :lessons))
      end

    end

    context "not signed in user" do
      it "should respond with a 403 status code" do
        get :show, id: course_1.slug
        expect(response.status).to eq(403)
      end
    end

  end


end