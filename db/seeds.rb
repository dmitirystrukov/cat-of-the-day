@user = FactoryGirl.create(:user_with_profile)

10.times { FactoryGirl.create(:day_theme, user: @user) }
