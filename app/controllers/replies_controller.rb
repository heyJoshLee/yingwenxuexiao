class RepliesController < ApplicationController

  before_action :set_reply, only: [:show, :update, :edit]
  before_action :set_comment, only: [:create]
  before_action :set_article, only: [:create]
  

  def create
    if params[:lesson_id]
      @lesson = Lesson.find_by(slug: params[:lesson_id])
      @course = Course.find_by(slug: params[:course_id])
      @reply = @comment.replies.build(reply_params)
      @reply.user_id = current_user.id

      if @reply.save
        flash[:success] = "Reply was saved"
        redirect_to course_lesson_path(@course, @lesson)
      else
        flash.now[:danger] = "There was a problem and the reply was not saved"
        render "lessons/show"
      end

    elsif
      @reply = @comment.replies.build(reply_params)
      @reply.user_id = current_user.id
      if @reply.save
        flash[:success] = "Reply was saved"
        redirect_to article_path(@article)
      else
        flash.now[:danger] = "There was a problem and the reply was not saved"
        render "articles/show"
      end
    end
  end


  private

  def set_comment
    @comment = Comment.find(params[:comment_id])
  end

  def set_article
    @article = Article.find_by(slug: params[:article_id])
  end

  def set_reply
    @reply = Reply.find_by(slug: params[:id])
  end

  def reply_params
    params.require(:reply).permit!
  end

end