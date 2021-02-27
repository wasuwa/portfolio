unless Rails.env.development? || Rails.env.test?
  CarrierWave.configure do |config|
    config.fog_credentials = {
      provider: 'AWS',
      aws_access_key_id: ENV['AWS_ACCESS_KEY_ID'],
      aws_secret_access_key: ENV['AWS_SECRET_ACCESS_KEY'],
      region: 'ap-northeast-1'
    }

    config.fog_directory = 'hssb-portfolio-s3'
    config.cache_storage = :fog
    # アクセスを許可する
    config.fog_public = false
    # fog-awsを使う
    config.fog_provider = 'fog-aws'
  end
end
