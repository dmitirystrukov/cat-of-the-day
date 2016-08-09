class DaySubjectImageUploader < BaseUploader
  version :thumb do
    process resize_and_pad: [350, 300]
  end
end
