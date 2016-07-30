require "spec_helper"

describe User do
  describe "#is_editor?" do

    it "should return true when user is an editor" do
      user = Fabricate(:user, role: "editor")
      expect(user.is_editor?).to be_truthy
    end


    it "should return false when user is a regular user" do
      user = Fabricate(:user)
      expect(user.is_editor?).to be_falsey
    end

    it "should return false when user is an admin" do
      user = Fabricate(:user, role: "admin")
      expect(user.is_editor?).to be_falsey

    end

  end # is_editor?

  describe "#is_admin?" do

    it "should return true when user is an admin" do
      user = Fabricate(:user, role: "admin")
      expect(user.is_admin?).to be_truthy
    end


    it "should return false when user is a regular user" do
      user = Fabricate(:user)
      expect(user.is_admin?).to be_falsey
    end

    it "should return false when user is an admin" do
      user = Fabricate(:user, role: "editor")
      expect(user.is_admin?).to be_falsey

    end
  end # is_admin?

  describe "#is_enrolled_in?" do
    let(:user) { Fabricate(:user) }
    let(:course) { Fabricate(:course) }

    it "should return false if user is not enrolled in the course" do
      expect(user.is_enrolled_in?(course)).to be_truthy
    end

    it "should return true id user is enrolled in the course" do
      user.enroll_in(course)
      expect(user.is_enrolled_in?(course)).to be_falsey
    end

  end


end