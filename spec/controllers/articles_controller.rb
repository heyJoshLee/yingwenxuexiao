require "rails_helper"

describe ArticlesController do

  describe "GET index" do
    let!(:article_1) { Fabricate(:article, published: true) }
    let!(:article_2) { Fabricate(:article) }

    it "should only show published articles" do
      get :index
      expect(assigns(:articles)).not_to include(article_2)
      expect(assigns(:articles)).to match_array([article_1])
    end
  end

  describe "GET show" do
    let(:published_article)  {Fabricate(:article, published: true) }
    let(:unpublished_article)  {Fabricate(:article) }

    it "allows the user to view view a published article" do
      get :show, id: published_article.slug
      expect(assigns(:article)).to eq(published_article)
    end

    it "redirects to the error path if the article is unpublished" do
      get :show, id: unpublished_article.slug
      expect(response).to redirect_to error_path
    end
  end
  
end