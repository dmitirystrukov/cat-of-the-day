@user = FactoryGirl.create(:user_with_profile)
@user.add_role :client

50.times { FactoryGirl.create(:day_subject, user: @user) }
