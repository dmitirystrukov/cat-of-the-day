@user = FactoryGirl.create(:user_with_profile)

10.times { FactoryGirl.create(:day_subject, user: @user) }
