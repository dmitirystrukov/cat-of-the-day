@user     = FactoryGirl.create(:user, :with_role, user_role: :client,   email: 'client@yahoo.com')
@consumer = FactoryGirl.create(:user, :with_role, user_role: :consumer, email: 'consumer@yahoo.com')

5.times { FactoryGirl.create(:day_subject, user: @user) }
