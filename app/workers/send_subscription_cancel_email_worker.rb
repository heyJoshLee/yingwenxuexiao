class SendSubscriptionCancelEmailWorker

  include Sidekiq::Worker

  def perform(user_id)
    AppMailer.subscription_cancel(User.find(user_id)).deliver_later
  end
end