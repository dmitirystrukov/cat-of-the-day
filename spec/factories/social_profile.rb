FactoryGirl.define do
  factory :social_profile do
    user
    uid { Faker::Number.number(6) }
    service_name { User::SOCIAL_PROVIDERS[send(:rand, User::SOCIAL_PROVIDERS.size)] }

    trait(:facebook) do
      after(:build) do |social_profile|
        social_profile.data = { 'token' => 'sometoken' }
        social_profile.service_name = 'facebook'
      end
    end

    trait(:twitter) do
      after(:build) do |social_profile|
        social_profile.data =
          {
            'consumer_key'        => 'somekey',
            'consumer_secret'     => 'somesecret',
            'access_token'        => 'someacesstoken',
            'access_token_secret' => 'sometoken'
          }

        social_profile.service_name = 'twitter'
      end
    end
  end
end
