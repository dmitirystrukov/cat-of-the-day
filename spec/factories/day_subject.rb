require 'factory_girl'

FactoryGirl.define do
  factory :day_subject do
    user

    title       { Faker::Name.title[0, 30] }
    description { Faker::Lorem.characters(100) }
  end
end
