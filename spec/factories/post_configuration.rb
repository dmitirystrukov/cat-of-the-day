FactoryGirl.define do
  factory :post_configuration do
    likes_count   { 5 }
    reposts_count { 10 }
  end
end
