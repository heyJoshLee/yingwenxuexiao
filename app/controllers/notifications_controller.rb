class NotificationsController < ApplicationController
  before_action :require_user
  before_action :set_notification, only: [:show, :update, :edit]


  def index
    current_user.notifications.each do |n|
      n.update_column(:read, true)
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