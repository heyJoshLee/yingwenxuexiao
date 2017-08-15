class CommentsController < ApplicationController

  before_action :require_user
  

  def create
    if params[:lesson_id]
      @course = Course.find_by(slug: params[:course_id])
      @lesson = Lesson.find_by(slug: params[:lesson_id])
      @comment = @lesson.comments.build(comment_params)
      @comment.author = current_user
      if @comment.save
        respond_to { |format| format.js }
      else
        respond_to do |format| 
          format.js { render "error" }
        end
      end

    elsif params[:article_id]
      @article = Article.find_by(slug: params[:article_id])
      @comment = @article.comments.build(comment_params)
      @comment.author = current_user

      if @comment.save
        respond_to { |format| format.js }
      else
        respond_to do |format| 
          format.js { render "error" }
        end
      end
    end
  end

  private

  def comment_params
    params.require(:comment).permit!
  end

end