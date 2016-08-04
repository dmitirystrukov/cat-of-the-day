FactoryGirl.define do
  factory :user do
    email    { Faker::Internet.email }
    password { 'password' }

    factory :user_with_profile do
      after(:create) { |user| create(:profile, user: user) }
    end

    factory :user_role do
      after(:create) { |user| user.add_role :client }
    end

    factory :client_role do
      after(:create) { |user| user.add_role :client }
    end
  end
end
