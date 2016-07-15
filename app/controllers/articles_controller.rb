class ArticlesController < ApplicationController

  before_action :set_article

  private

  def set_article
    @article = Article.find_by slug: params[:id]
  end

end
