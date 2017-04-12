class BaseUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick

  def store_dir
    case Rails.env
    when 'production'
      "https://#{ENV['AWS_BUCKET_NAME']}.s3.amazonaws.com/system/uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
    when 'development'
      "system/uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
    when 'test'
      "system/uploads/test/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
    end
  end

  def default_url
    ActionController::Base.helpers.asset_path 'admin/fallback/' + [model.class.to_s.underscore,
                                                                   mounted_as, version_name, 'default.jpg'].compact.join('_')
  end

  def extension_white_list
    %w(jpg jpeg gif png)
  end
end
