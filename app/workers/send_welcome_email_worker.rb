class SendWelcomeEmailWorker
  include Sidekiq::Worker

  def perform(user_id)
    AppMailer.send_welcome_email(User.find(user_id)).deliver_later
  end


end