FactoryGirl.define do
  factory :social_post do
    user

    post_id { Faker::Number.number(6) }
    message { Faker::Lorem.characters(100) }
  end
end
