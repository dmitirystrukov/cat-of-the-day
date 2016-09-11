FactoryGirl.define do
  factory :user do
    email    { Faker::Internet.email }
    password { 'password' }

    after(:create) do |user| 
      create(:profile, user: user)
    end

    trait(:with_role) do
      ignore do
        user_role nil
      end

      after(:create) { |user, evaluator| user.add_role evaluator.user_role }
    end
  end
end
