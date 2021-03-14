unless Rails.env.development? || Rails.env.test?
  CarrierWave.configure do |config|
    if Rails.env.production?
      # 本番時にはAWS S3に保存するように設定
      config.fog_credentials = {
        provider: 'AWS',
        aws_access_key_id: ENV['AWS_ACCESS_KEY_ID'],
        aws_secret_access_key: ENV['AWS_SECRET_ACCESS_KEY'],
        region: 'ap-northeast-1'
      }

      config.fog_public     = false
      config.fog_directory  = ENV['AWS_BUCKET_NAME']
      config.cache_storage = :fog
    else
      # ローカルではフォルダに保存するように設定
      config.storage = :file
    end
  end
end