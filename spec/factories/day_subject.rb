require 'factory_girl'

FactoryGirl.define do
  factory :day_subject do
    user

    title       { Faker::Name.title[0, 30] }
    description { Faker::Lorem.characters(100) }

    factory :with_image do
      after(:create) { |day_subject| create(:day_subject_image, day_subject: day_subject) }
    end
  end
end
