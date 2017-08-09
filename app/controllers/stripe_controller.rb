class StripeController < ApplicationController
  skip_before_filter :verify_authenticity_token

  def index
    type = params["type"]
    if type == "customer.subscription.deleted"
      delete_subscription 
    elsif type == "charge.succeeded" 
      payment_made
    else 
      render json: {
        message: "No action completed",
        status: 200
      }, status: 200
    end
  end


  private

  def payment_made
    stripe_id = params["data"]["object"]["customer"]

    if !stripe_id
      message = "No stripe ID!!!!"
    else

      if user = User.find_by(stripeid: stripe_id) 
        user.update_column(:membership_level, "paid")
        message = "Payment made for #{user.email}"
        amount = params["data"]["object"]["amount"].to_f
        currency = params["data"]["object"]["currency"]

        # send email to user
        # send email to admin
        Payment.create(
          stripe_id: stripe_id,
          currency: currency,
          user_id: user.id,
          amount: amount
        )

      SendStripeChargeEmailWorker.perform_async(user.id, amount, currency)

      SendAdminPaymentNotificationEmailWorker.perform_async(user.id, amount, currency)

      else

        message = "payment_made, but  "
        message += "couldn't find user with stripeid: #{stripe_id}"

      end
    end



      render json: {
        message: message,
        status: 200
      }, status: 200

  end

  def delete_subscription
     
    stripe_id = params["data"]["object"]["customer"]
    user = User.find_by(stripeid: stripe_id)
    if user 
      user.update_column(:membership_level, "free")
      message = "Ended subscription for #{user.email}"
      SendSubscriptionCancelEmailWorker.perform_async(user.id)
      SendNotifyAdminOfSubscriptionCancelEmailWorker.perform_async(user.id)
      
    else
      message = "Tried to cancel subscription, but "
      message += "couldn't find user with stripeid: #{stripe_id}"
    end

    render json: {
      message: message,
      status: 200
    }, status: 200
  end

end