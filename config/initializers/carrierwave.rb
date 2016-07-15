CarrierWave.configure do |config|
  config.store_dir = 'public/tmp/'
  if (Rails.env.production? || Rails.env.staging?)
    config.store_dir = 'public/tmp/'
    config.storage         = :aws
    config.aws_bucket      = ENV['AWS_S3_BUCKET']
    config.aws_credentials = {
      access_key_id:     ENV['AWS_ACCESS_KEY_ID'],
      secret_access_key: ENV['AWS_SECRET_ACCESS_KEY'],
      region:            ENV['AWS_REGION']
    }
  else
    config.store_dir = 'spec/' if Rails.env.test?
    config.store_dir = 'tmp/' if Rails.env.development?
    config.storage = :file
    config.enable_processing = Rails.env.development?
  end
end