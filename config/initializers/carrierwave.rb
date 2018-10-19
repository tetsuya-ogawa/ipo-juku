CarrierWave.configure do |config|
  config.fog_credentials = {
      provider: 'AWS',
      aws_access_key_id: '',
      aws_secret_access_key: '+GczB09v',
      region: 'ap-northeast-1'
  }

  config.fog_directory = 'directory'
  # config.cache_storage = :fog
  # config.fog_credentials = {
  #     provider: 'AWS',
  #     aws_access_key_id: '',
  #     aws_secret_access_key: '',
  #     region: 'ap-northeast-1'
  # }
  # config.fog_public = true
  # config.storage = Rails.env.development? ? :file : :fog
  # config.remove_previously_stored_files_after_update = false
  # bucket_name = Settings.s3.bucket || 'evekastu'
  # config.fog_directory = bucket_name
  # # config.asset_host = if Rails.env.development? || Rails.env.test?
  # #                       uri = URI.parse Settings.site_url
  # #                       "#{uri.host}:#{uri.port}"
  # #                     else
  # #                       "#{bucket_name}.s3.amazonaws.com"
  # #                     end
  # config.cache_dir = "#{Rails.root}/tmp/uploads"
  # config.fog_attributes = {cache_control: 'max-age=604800', expires: 1.week.from_now.httpdate}
end