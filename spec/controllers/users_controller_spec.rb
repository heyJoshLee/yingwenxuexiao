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

    it "doesn't create user if params aren't passed" do
      post :create, user: {name: "joe"}
      expect(User.count).to eq(0);
    end

    it "creates a user with an affiliate link" do
      affiliate = Fabricate(:affiliate)
      affiliate_link = Fabricate(:affiliate_link, code: "abc123", affiliate_id: affiliate.id)
      session[:affiliate_link_code] = affiliate_link.code
      post :create, user: {name: "John Doe", password: "Coolpass123", email: "John@google.com"}
      expect(User.last.affiliate_link_id).to eq(affiliate_link.id)
    end
  end
end
