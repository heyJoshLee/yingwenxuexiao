class SubscribersController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [:stripe_charge]
  before_action :require_user

def create

  user = current_user
  # Get the credit card details submitted by the form
  token = params[:stripeToken]

  # Create a Customer
  customer = Stripe::Customer.create(
    :email => current_user.email,
    :source  => token
  )
  stripe_subscription = Stripe::Subscription.create(
    :customer => customer.id,
    :plan => 1
  )
  user.update_column(:membership_level, "paid")
  user.update_column(:stripeid, customer.id)

  rescue Stripe::CardError => e
    flash[:error] = e.message
    redirect_to new_charge_path

end # create

def stripe_charge
  begin
    event_json = JSON.parse(request.body.read)
    event_object = event_json['data']['object']
    #refer event types here https://stripe.com/docs/api#event_types
    Rails.logger.debug { "The event is #{event_json['type']}" }
    case event_json['type']
      when 'invoice.payment_succeeded'
        user  = User.find_by(stripeid: event_object["customer"])
        user.update_column(:membership_level, "paid") if user
        if user
          Rails.logger.debug { "Update the user to be a paid user." }
        else
          Rails.logger.debug { "The user with the data was not found." }
        end
        # lets store this payment in the database as well
        subscription = Subscription.find_by(stripe_id: event_object["subscription"])
        Rails.logger.debug { "The subscription is #{subscription.id}" }
        render :status => 200
      when 'invoice.payment_failed'
        Rails.logger.debug { "The stripeid is #{event_object['customer']}" }
        user = User.find_by(stripeid: event_object["customer"])
        if user
          Rails.logger.debug { "User was found!" }
        else
          Rails.logger.debug { "User was not found and hence not updated." }
        end
        user.update_column(:membership_level, "free") if user
        Rails.logger.debug { "Updated the user to be a free user." }
        render :status => 200
      when 'charge.failed'
        user = User.find_by(stripeid: event_object["customer"])
        user.update_column(:membership_level, "free") if user
        render :status => 200
      when 'customer.subscription.deleted'
      when 'customer.subscription.updated'
    end
  rescue Exception => ex
    render :json => {:status => 422, :error => "Webhook call failed"}
    return
  end
  render :json => {:status => 200}

end # Stripe_charge

private

def handle_success_invoice(user)
  user.update_column(:membership_level, "paid")
end

  # binding.pry
  # stripe web hook

  # user User.find_by(stripeid: params[:stripe_id)

  # if request.good?
  #   user.keep_membership
  # else
  #   user.to_free_membership
  # end

    # binding.pry

    # user.paid_member?



# def destroy

#   # add a delete method for the subscription
#   sub = Stripe::Subscription.retrieve(user.subscriptionid)
#   sub.delete

#   user.membership_level = "free"
#   # end delete method

# end

end #class
