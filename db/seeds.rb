@user = FactoryGirl.create(:user_with_profile)

50.times { FactoryGirl.create(:day_subject, user: @user) }
