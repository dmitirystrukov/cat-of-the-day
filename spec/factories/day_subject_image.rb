require 'factory_girl'

FactoryGirl.define do
  factory :day_subject_image do
    day_subject
    url { Rack::Test::UploadedFile.new(File.open('spec/fixtures/cat.jpg'), 'image/jpg') }
  end
end
