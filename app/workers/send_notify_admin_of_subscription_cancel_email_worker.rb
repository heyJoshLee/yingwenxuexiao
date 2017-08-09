class SendNotifyAdminOfSubscriptionCancelEmailWorker
  include Sidekiq::Worker

  def perform(user_id)
    AppMailer.notify_admin_of_subscription_cancel(User.find(user_id)).deliver_later 
  end

end