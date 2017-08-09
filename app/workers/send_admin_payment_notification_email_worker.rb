class SendAdminPaymentNotificationEmailWorker
  include Sidekiq::Worker

  def perform(user_id, amount, currency)
    AppMailer.admin_payment_notification(User.find(user_id), amount, currency).deliver_later
  end
end