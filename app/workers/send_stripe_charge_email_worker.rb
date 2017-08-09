class SendStripeChargeEmailWorker
include Sidekiq::Worker


  def perform(user_id, amount, currency)
    AppMailer.stripe_charge(User.find(user_id), amount, currency).deliver_later
  end


end