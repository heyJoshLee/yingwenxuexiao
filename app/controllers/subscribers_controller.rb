class SubscribersController < ApplicationController
  
  protect_from_forgery with: :null_session
  
  # before_action :require_user
    
def create

  user = User.first
  
  # Get the credit card details submitted by the form
  token = params[:stripeToken]
  
  # Create a Customer
  
  # try
  customer = Stripe::Customer.create(
    :source => token,
    :plan => 1001,
    :email => user.email
  )
  
  # id doesn't work redirect
    # redirect to not_charged_path
  
  # else
  
    user.update_column(:membership_level, "paid")
    user.update_column(:stripeid, customer.id)
  
  
  # try
  
  subscription = Stripe::Subscription.create(
    :customer => user.stripeid,
    :plan => 1001
  )
  
  user.subscriptionid = subscription.id;
  
  rescue Stripe::CardError => e
    flash[:error] = e.message
    redirect_to new_charge_path

end # create

def stripe_charge
  
  begin
    event_json = JSON.parse(request.body.read)
    event_object = event_json['data']['object']
    #refer event types here https://stripe.com/docs/api#event_types
    case event_json['type']
      when 'invoice.payment_succeeded'
        user  = User.find_by(stripeid: event_object["customer"])
        user.update_column(:membership_level, "paid") if user
        render :status => 200
      when 'invoice.payment_failed'
        user = User.find_by(stripei: event_object["customer"])        
        user.update_column(:membership_level, "free") if user
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










