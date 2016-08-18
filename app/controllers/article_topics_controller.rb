class ArticleTopicsController < ApplicationController

  before_action :set_article_topic, only: [:show]

  def show
    add_breadcrumb "Articles", blog_path
    add_breadcrumb @article_topic.name
  end
  
  private

  def set_article_topic
    @article_topic = ArticleTopic.find_by(slug: params[:id])
  end

end