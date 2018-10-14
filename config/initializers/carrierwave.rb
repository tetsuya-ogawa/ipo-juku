CarrierWave.configure do |config|
  config.fog_credentials = {
      provider: 'AWS',
      aws_access_key_id: '',
      aws_secret_access_key: '+GczB09v',
      region: 'ap-northeast-1'
  }

  config.fog_directory  = 'directory'
  config.cache_storage = :fog
end