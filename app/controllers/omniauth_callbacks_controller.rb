class OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def facebook
    process_callback
  end

  def vkontakte
    process_callback
  end

  private

  def process_callback
    oauth_data = request.env['omniauth.auth']
    sign_in_with_oauth_data(oauth_data) unless user_signed_in?

    current_user.register_social_profile(oauth_data.provider, oauth_data.uid)

    redirect_to root_path
  end

  def sign_in_with_oauth_data(data)
    profile_user = SocialProfile.owner_by_unique_id(data[:uid])

    unless profile_user
      temporary_email = "#{data[:uid]}@email.com}"
      user = User.create(email: temporary_email)
    end

    sign_in :user, profile_user || user
  end
end
