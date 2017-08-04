class StripeController < ApplicationController
  skip_before_filter :verify_authenticity_token

  def index
    puts "Hit stripe webhook"
    type = params["type"]
    delete_subscription if type == "customer.subscription.deleted"
    payment_made if type == "charge.succeeded" 
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
        amount = params["data"]["object"]["amount"]
        currency = params["data"]["object"]["currency"]

        # send email to user
        # send email to admin
        Charge.create(
          stripe_id: stripe_id,
          currency: currency,
          user_id: user.id,
          amount: amount
        )
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
      # send email
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