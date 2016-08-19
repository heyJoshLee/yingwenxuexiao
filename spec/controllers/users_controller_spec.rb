require "rails_helper"

describe UsersController do
  describe "GET new" do
    it "sets @user" do
      get :new
      assigns(:user).should be_instance_of(User)
    end
  end

  describe "POST create" do
    it "creates a user without an affiliate link" do
      post :create, user: {name: "John Doe", password: "Coolpass123", email: "John@google.com"}
      expect(User.count).to eq(1);
    end
  end
end