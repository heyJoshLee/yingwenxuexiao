class SendForgotPasswordEmailWorker
  include Sidekiq::Worker

  def perform(user_id)
    AppMailer.send_forgot_password(User.find(user_id)).deliver_later
  end

end