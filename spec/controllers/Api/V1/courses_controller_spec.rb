require "rails_helper"


describe Api::V1::CoursesController do

  describe "GET index" do


    let!(:course_1) { Fabricate(:course)}
    let!(:course_2) { Fabricate(:course)}
    it "should respond with JSON containing all courses" do
      get :index
      expect(response.body).to eq(Course.all.to_json)
    end

  end


end