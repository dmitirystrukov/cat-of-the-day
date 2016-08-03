FactoryGirl.define do
  factory :social_profile do
    user
    uid { Faker::Number.number(6) }
    service_name { User::SOCIAL_PROVIDERS[send(:rand, User::SOCIAL_PROVIDERS.size)] }
  end
end
