class PictureUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
    # 'public/upload/game_pictures'
  end

  def default_url
    ActionController::Base.helpers.asset_path(
      'fallback/' + [version_name, 'default.png'].compact.join('_')
    )
  end

  version :large do
    process resize_to_fit: [300, 300]
  end

  version :carousel do
    process resize_to_fill: [1080, 720]
  end

  def extension_whitelist
    %w(jpg jpeg gif png)
  end
end
