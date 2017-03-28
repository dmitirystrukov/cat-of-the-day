FactoryGirl.define do
  factory :profile do
    first_name { Faker::Name.first_name }
    last_name  { Faker::Name.last_name }
    location   { "#{Faker::Address.city}, #{Faker::Address.state}" }
    website    { Faker::Internet.url('example.com') }
  end
end
