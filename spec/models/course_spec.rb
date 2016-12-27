require "spec_helper"

describe Course do
  it { should have_many(:lessons) }
  it { should have_many(:units) }
  it { should validate_presence_of(:name)}
  it { should validate_presence_of(:description)}

  describe "#published_lessons" do
    let!(:course) { Fabricate(:course) }
    let!(:unpublished_lesson) { Fabricate(:lesson, course_id: course.id) }
    let!(:published_lesson) { Fabricate(:lesson, course_id: course.id, published: true) }

    it "returns the lessons marked as published" do
      expect(course.published_lessons).not_to include(:unpublished_lesson)
      expect(course.published_lessons).to match_array([published_lesson])
    end
  end

  describe ".published_courses" do
    let!(:published_course) { Fabricate(:course, name: "Published Course", published: true) }
    let!(:unpublished_course) { Fabricate(:course, name: "Unpublished Course") }

    it "should return an array with only published courses" do
      expect(Course.published_courses).to eq([published_course])
    end 
  end

  describe ".create" do
    it "should create a unit and associate the unit to the course after being created" do
     course = Fabricate(:course)
     expect(course.units.count).to eq(1)
    end
  end
end