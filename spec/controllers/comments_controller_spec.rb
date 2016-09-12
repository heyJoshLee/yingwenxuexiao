require "rails_helper"

describe CommentsController do
  let(:article) { Fabricate(:article) }
  let(:alice) { Fabricate(:user) }

  describe "POST create" do
    it "doesn't create a comment if the user is not logged in" do
      post :create, article_id: article.slug, comment: {body: "nice article"}, format: :js
      expect(Comment.count).to eq(0)
    end

    it "creates a comment if the user is logged in" do
      set_current_user
      post :create, article_id: article.slug, comment: {body: "nice article"}, format: :js
      expect(Comment.count).to eq(1)
    end

    it "associates the user to the comment" do
      set_current_user(alice)
      post :create, article_id: article.slug, comment: {body: "nice article"}, format: :js
      expect(Comment.last.user_id).to eq(alice.id)
    end

    it "associate the comment to the article" do
      set_current_user(alice)
      post :create, article_id: article.slug, comment: {body: "nice article"}, format: :js
      expect(Comment.last.commentable_id).to eq(article.id)
    end
  end

end