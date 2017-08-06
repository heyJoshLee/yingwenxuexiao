require "rails_helper"

describe LessonsController do

  describe "POST complete" do
  end


  describe "GET show" do

    context "not logged in" do
      it "should redirect to sign in page"
    end

    context "free user logged in free course-lesson" do
      it "assigns @lesson"
    end 

    context "free user logged in premium course-lesson" do
      it "redirects to upgrade path"
    end 

    context "paid user logged in course" do
      it "assigns lesson"
    end



  end # GET show



end