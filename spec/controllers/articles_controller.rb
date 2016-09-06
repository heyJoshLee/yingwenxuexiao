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

end