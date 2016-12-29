require "rails_helper"

describe Admin::ArticlesController do

 describe "DELETE destroy" do

    it "doesn't allow an unsigned in user to delete an article" do
      article = Fabricate(:article)
      delete :destroy, id: article.slug
      expect(Article.count).to eq(1)
    end

    it "doesn't allow a non admin to delete an article" do
      set_current_user
      article = Fabricate(:article)
      delete :destroy, id: article.slug
      expect(Article.count).to eq(1)
    end

    it "allows an admin to delete an article" do
      set_current_user(Fabricate(:user, role: "admin"))
      article = Fabricate(:article)
      delete :destroy, id: article.slug
      expect(Article.count).to eq(0)
    end

  end

end