class Admin::ArticlesController < ApplicationController
  
  def new
    @article = Article.new
  end

  def create
    @article = Article.new(article_params)
    if @article.save
      flash[:success] = "Article was saved"
      redirect_to article_path(@article)
    else
      flash.new[:danger] = "There was a problem and the article was not saved"
      render :new
    end
  end

  def edit
    @article = Article.find_by(slug: params[:id])
  end

  private

  def article_params
    params.require(:article).permit(:title, :main_image_url, :body, :category_id, :bootsy_image_gallery_id)
  end

end