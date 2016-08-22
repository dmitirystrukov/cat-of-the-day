@user = FactoryGirl.create(:user_with_profile, email: 'admin@yahoo.com')
@user.add_role :client

50.times { FactoryGirl.create(:day_subject, user: @user) }
