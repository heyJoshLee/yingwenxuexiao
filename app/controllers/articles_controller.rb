class ArticlesController < ApplicationController

  before_action :set_article

  def index
    @articles = Article.all
  end

  private

  def set_article
    @article = Article.find_by slug: params[:id]
  end

end
