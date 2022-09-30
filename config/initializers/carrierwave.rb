CarrierWave.configure do |config|
  if Rails.env.development? || Rails.env.test?
    config.storage = :file
    config.enable_processing = Rails.env.development?
  else
    config.fog_credentials = {
      provider: 'AWS',
      aws_access_key_id: ENV['AWS_ACCESS_KEY'],
      aws_secret_access_key: ENV['AWS_SECRET_KEY'],
      region: ENV['AWS_REGION']
    }
    config.fog_directory = ENV['AWS_BUCKET']
    config.fog_public = false
    config.cache_dir = "#{Rails.root}/tmp/uploads"
    config.storage = :fog
  end
end
