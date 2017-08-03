Rails.application.configure do

  config.web_console.whiny_requests = false

config.cache_classes = false

  # Show full error reports and disable caching
  config.consider_all_requests_local       = true
  config.action_controller.perform_caching = false

  # Don't care if the mailer can't send
  config.action_mailer.raise_delivery_errors = false
  config.action_mailer.delivery_method = :letter_opener
  config.action_mailer.default_url_options = { host: "localhost:3000"}

  

  

  # Print deprecation notices to the Rails logger
  config.active_support.deprecation = :log
  config.log_level = :debug

  # Do not compress assets
  config.assets.compress = false

  # Expands the lines which load the assets
  config.assets.debug = true

  config.eager_load = false
end
