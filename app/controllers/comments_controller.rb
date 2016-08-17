class CommentsController < ApplicationController
  

  def create
    if params[:lesson_id]
      @course = Course.find_by(slug: params[:course_id])
      @lesson = Lesson.find_by(slug: params[:lesson_id])
      @comment = @lesson.comments.build(comment_params)
      @comment.author = current_user

      if @comment.save
        
        flash[:success] = "Your comment was saved"
        redirect_to course_lesson_path(@course, @lesson)
      else
        flash.now[:danger] = "Your comment was not saved"
        render "lessons/show"
      end

    elsif params[:article_id]
      @article = Article.find_by(slug: params[:article_id])
      @comment = @article.comments.build(comment_params)
      @comment.author = current_user

      if @comment.save
        flash[:success] = "Your comment was saved"
        redirect_to article_path(@article)
      else
        flash.now[:danger] = "There was a problem and the comment was not saved"
        render "articles/show"
      end
    end
  end

  private

  def comment_params
    params.require(:comment).permit!
  end

end