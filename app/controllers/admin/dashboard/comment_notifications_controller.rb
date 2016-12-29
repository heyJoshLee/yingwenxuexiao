class Admin::Dashboard::CommentNotificationsController < AdminController

  before_action :set_comment_notification, only: [:show, :update, :edit, :toggle, :destroy]
  
  def index
   @comment_notifications = current_user.comment_notifications
  end

  def toggle
    @comment_notification.toggle_read
    redirect_to admin_dashboard_comment_notifications_path
  end

  def check_all
    ActiveRecord::Base.transaction do
      CommentNotification.where(read: false).each do |notification|
        new_boolean = !notification.read?
        notification.update_column(:read, new_boolean)
      end
    end
    flash[:success] = "All notifications are now marked as read"
    redirect_to admin_dashboard_comment_notifications_path
  end

  def destroy
    @comment_notification.delete
    redirect_to admin_dashboard_comment_notifications_path
  end

  private

  def set_comment_notification
    @comment_notification = CommentNotification.find_by(slug: params[:id])
  end

  def comment_notification_params
    params.require(:comment_notification).permit!
  end

end