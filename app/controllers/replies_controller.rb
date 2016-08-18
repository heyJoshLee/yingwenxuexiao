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
    elsif
      @reply = @comment.replies.build(reply_params)
      @reply.user_id = current_user.id
    end

    if @reply.save
      respond_to { |format| format.js }
    else
      respond_to do |format| 
        format.js { render "error" }
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