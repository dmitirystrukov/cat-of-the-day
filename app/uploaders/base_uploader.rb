class BaseUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick

  def store_dir
    model_dir = "#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"

    if Rails.env.test?
      "#{Dir.pwd}/system/uploads/test/#{model_dir}"
    else
      "system/uploads/#{model_dir}"
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
