@user     = FactoryGirl.create(:user, :with_role, user_role: :client,   email: 'client@example.com')
@consumer = FactoryGirl.create(:user, :with_role, user_role: :consumer, email: 'consumer@example.com')

@day_subject = FactoryGirl.create(:day_subject_with_image, user: @user)

# Statistic Chart demo data
((Date.today - 7)..Date.today).each do |date|
  post_types = %w(TwitterPost FacebookPost)

  rand(5..25).times do |time|
    FactoryGirl.create(:social_post, user: @user, day_subject_id: @day_subject.to_param, message: "somemessage-#{time}", created_at: date,
                                     day_subject_image_id: @day_subject.day_subject_images.first.to_param, service_name: post_types[rand(0..1)])
  end
end
