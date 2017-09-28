require "spec_helper"

describe UserAction do



  describe ".create_user_action" do
    let!(:user) { Fabricate(:user) }
    let!(:course) { Fabricate(:course, published: true, premium_course: true) }
    let!(:lesson) { Fabricate(:lesson, course_id: course.id, published: true) }

    it "creates a body for completing a lesson" do
      hash_object = {
        lesson_id: lesson.id,
        action_type: "completed lesson"
      }
      UserAction.create_user_action(user.id, hash_object)
      expect(UserAction.last.body).to eq("#{user.email} completed lesson #{lesson.name} in #{course.name}\n\n courses/#{course.slug}/lessons/#{lesson.slug}")
    end

    it "creates a body for signing up" do
      hash_object = {
        action_type: "signed up"
      }
      UserAction.create_user_action(user.id, hash_object)
      expect(UserAction.last.body).to eq("#{user.email} signed up.")

    end
  end


end