FactoryGirl.define do
  factory :social_post do
    user

    url     { 'someurl' }
    post_id { Faker::Number.number(6) }
    message { Faker::Lorem.characters(100) }
    data    { build(:post_configuration) }
  end
end
