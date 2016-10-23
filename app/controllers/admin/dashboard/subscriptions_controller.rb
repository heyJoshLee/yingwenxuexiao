class Admin::Dashboard::SubscriptionsController < AdminController
  require "stripe"

  before_action :set_subscription, only: [:show, :update, :edit]
  
  def index
    @subscription = Subscription.new
  end

  def create
   @subscription = Subscription.new(subscription_params)
    if @subscription.valid?
        stripe_subscription = Stripe::Plan.create(
        :amount => (@subscription.price * 100).to_i,
        :interval => "month",
        :name => @subscription.name,
        :currency => @subscription.currency,
        :id => SecureRandom.uuid # This ensures that the plan is unique in stripe
      )
      @subscription.stripe_id = stripe_subscription.id
        if @subscription.save
          flash[:success] = "You have successfully created a subscription."
          redirect_to admin_dashboard_subscriptions_path
        else
          flash.now[:error] = "Subscription was not created."
          render :index
        end
    else
      flash.now[:error] = "Subscription was not created."
      render :index
    end
  end

  def update
    if @subscription.update(@subscription_params)
      flash[:success] = "subscription was saved"
      redirect_to subscription_path(@subscription)
    else
      flash.now[:danger] = "There was a problem and the subscription was not saved"
      render :edit
    end
  end


  # def stripe_checkout
  #   @amount = 10
  #   #This will create a charge with stripe for $10
  #   #Save this charge in your DB for future reference
  #   charge = Stripe::Charge.create(
  #                   :amount => @amount * 100,
  #                   :currency => "usd",
  #                   :source => params[:stripeToken],
  #                   :description => "Test Charge"
  #   )
  #   flash[:notice] = "Successfully created a charge"
  #   redirect_to root_path
  # end

  private

  def set_subscription
    @subscription = Subscription.find_by(slug: params[:id])
  end

  def subscription_params
    params.require(:subscription).permit!
  end

end