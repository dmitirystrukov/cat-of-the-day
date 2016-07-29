require 'factory_girl'

FactoryGirl.define do
  factory :day_theme do
    title       { Faker::Name.title }
    description { Faker::Lorem.characters(100) }
  end
end
