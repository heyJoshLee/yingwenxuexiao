class ArticlesController < ApplicationController

  before_action :set_article, only: [:show]
  add_breadcrumb "Home", :root_path
  add_breadcrumb "Blog", :blog_path

  def show
    @comment = Comment.new
    add_breadcrumb @article.title, @article
  end

  def index
    if logged_in? && current_user.is_admin?
      @articles = Article.all
    else
      @articles = Article.where(published: true)
    end
  end

  private

  def set_article
    @article = Article.find_by slug: params[:id]
    redirect_to error_path unless @article.published? || logged_in? && current_user.is_admin?
  end

end
