require "spec_helper"

describe Course do
  it { should have_many(:lessons) }
  it { should have_many(:units) }
  it { should validate_presence_of(:name)}
  it { should validate_presence_of(:description)}

  describe "#published_lessons" do
    let!(:course) { Fabricate(:course) }
    let!(:unpublished_lesson) { Fabricate(:lesson, course_id: course.id) }
    let!(:unpublished_lesson_2) { Fabricate(:lesson, course_id: course.id) }
    let!(:published_lesson) { Fabricate(:lesson, course_id: course.id, published: true) }
    let!(:published_lesson_2) { Fabricate(:lesson, course_id: course.id, published: true) }

    it "returns the lessons marked as published" do
      expect(course.published_lessons).not_to include([:unpublished_lesson, :unpublished_lesson_2])
      expect(course.published_lessons).to match_array([published_lesson, published_lesson_2])
    end
  end


  describe ".premium_published_courses" do
    let!(:published_course) { Fabricate(:course, name: "Published Course", published: true) }
    let!(:unpublished_premium_course) { Fabricate(:course, name: "Unpublished Premium Course", published: false) }
    let!(:published_course) { Fabricate(:course, name: "Published Free Course", published: true) }

    it "should return an array with only published courses" do
      expect(Course.premium_published_courses).to eq([published_course])
    end 
  end

  describe ".free_published_courses" do
    let!(:premium_published_course) { Fabricate(:course, name: "Premium Course", published: true) }
    let!(:free_published_course) { Fabricate(:course, name: "Free Course", published: true, premium_course: false) }
    let!(:free_unpublished_course) { Fabricate(:course, name: "Free Unpublished Course", published: false, premium_course: false) }

    it "should return only the free published course" do
      expect(Course.free_published_courses).to eq([free_published_course])
    end
  end

  describe ".create" do
    it "should create a unit and associate the unit to the course after being created" do
     course = Fabricate(:course)
     expect(course.units.count).to eq(1)
    end
  end
end