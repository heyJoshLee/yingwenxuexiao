class CommentsController < ApplicationController
  

  def create
    @article = Article.find_by(slug: params[:article_id])
    @comment = @article.comments.build(comment_params)
    @comment.author = User.find(session[:user_id])

    if @comment.save
      flash[:success] = "Your comment was saved"
      redirect_to article_path(@article)
    else
      flash.now[:danger] = "There was a problem and the comment was not saved"
      render "articles/show"
    end
  end

  private

  def comment_params
    params.require(:comment).permit!
  end

end