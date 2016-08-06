class DaySubjectImageUploader < BaseUploader
  version :thumb do
    process resize_and_pad: [150, 100]
  end
end
