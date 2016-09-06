class ArticlesController < ApplicationController

  before_action :set_article, only: [:show]
  add_breadcrumb "Home", :root_path
  add_breadcrumb "Blog", :blog_path

  def show
    @comment = Comment.new
    add_breadcrumb @article.title, @article
  end

  def index
    @articles = Article.where(published: true)
  end

  private

  def set_article
    @article = Article.find_by slug: params[:id]
  end

end
