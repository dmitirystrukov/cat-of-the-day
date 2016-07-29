class ProfileImageUploader < BaseUploader
  version :user_thumb do
    process resize_and_pad: [64, 64]
  end
end
