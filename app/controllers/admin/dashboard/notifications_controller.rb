class Admin::Dashboard::NotificationsController < AdminController

  before_action :set_notification, only: [:show, :update, :edit]
  
  def new
    @notification = Notification.new
  end

  def create
    begin
      current_user.send_notification(notification_params.except(:receiver_id), User.all)
    rescue ActiveRecord::RecordInvalid
      flash[:error] = "Invalid position number"
      render :new
    end

    flash[:success] = "Notifications were sent"
    redirect_to admin_dashboard_notifications_path
  end

  def update
    if @notification.update(@notification_params)
      flash[:success] = "notification was saved"
      redirect_to notification_path(@notification)
    else
      flash.now[:danger] = "There was a problem and the notification was not saved"
      render :edit
    end
  end

  private

  def set_notification
    @notification = Notification.find_by(slug: params[:id])
  end

  def notification_params
    params.require(:notification).permit!
  end

end