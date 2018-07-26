class PictureUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick

  storage :aws

  process :resize_to_limit => [nil, 500]

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  def extension_whitelist
    %w(jpg jpeg gif png)
  end

  def filename
      "#{secure_token(10)}.#{file.extension}" if original_filename.present?
  end

  protected
  
  def secure_token(length=16)
    var = :"@#{mounted_as}_secure_token"
    model.instance_variable_get(var) or model.instance_variable_set(var, SecureRandom.hex(length/2))
  end

end
