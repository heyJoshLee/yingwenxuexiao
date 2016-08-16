class Admin::ArticleTopicsController < ApplicationController

  before_action :set_article_topic, only: [:show, :update, :edit]
  
  def new
    add_breadcrumb "Article Topics", admin_article_topics_path
    add_breadcrumb "New Topic"
    @article_topic = ArticleTopic.new
  end

  def index
    add_breadcrumb "Article Topics", admin_article_topics_path
    @article_topics = ArticleTopic.all
  end

  def create
    @article_topic = ArticleTopic.new(article_topic_params)
    if @article_topic.save
      flash[:success] = "article_topic was saved"
      redirect_to admin_article_topics_path
    else
      flash.now[:danger] = "There was a problem and the article_topic was not saved"
      render :new
    end
  end

  def edit
  end

  private

  def set_article_topic
    @article_topic = ArticleTopic.find_by(slug: params[:id])
  end

  def article_topic_params
    params.require(:article_topic).permit!
  end

end