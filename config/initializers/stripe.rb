if Rails.env == "production"
  Rails.configuration.stripe = {
    :publishable_key => ENV['STRIPE_PUBLISHABLE_KEY'],
    :secret_key      => ENV['STRIPE_SECRET_KEY']
  }
else
  Rails.configuration.stripe = {
    :publishable_key => 'pk_test_Aa0rljrHUP0FgKy7o80SI8yT',
    :secret_key      => 'sk_test_goNOUrBVj5ycZbZXqHZCeKOH'
  }
end

Stripe.api_key = Rails.configuration.stripe[:secret_key]
