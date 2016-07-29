FactoryGirl.define do
  factory :user do
    email    { Faker::Internet.email }
    password { 'password' }

    factory :user_with_profile do
      after(:create) { |user| create(:profile, user: user) }
    end
  end
end
