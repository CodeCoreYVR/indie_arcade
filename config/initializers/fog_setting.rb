CarrierWave.configure do |config|
 if Rails.env.development?
   config.storage = :file
 else
   config.fog_provider = 'fog/aws'
   config.fog_credentials = {
     provider:              'AWS',
     aws_access_key_id:     ENV['AWS_ACCESS_KEY_ID'] || '',
     aws_secret_access_key: ENV['AWS_SECRET_ACCESS_KEY'] || '',
     region:                'us-west-2'
   }
   # Change folder name to s3 bucket name in production env
   config.fog_directory  = ENV['AWS_BUCKET'] || ''
   config.fog_public     = false                                        # optional, defaults to true
   config.fog_attributes = { 'Cache-Control' => "max-age=#{365.day.to_i}" } # optional, defaults to {}
 end
end
