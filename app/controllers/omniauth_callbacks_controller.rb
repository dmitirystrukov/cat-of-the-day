class OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def facebook
    process_callback
  end

  def twitter
    process_callback
  end

  def vkontakte
    process_callback
  end

  private

  def process_callback
    oauth_data = request.env['omniauth.auth']

    sign_in_with_oauth_data(oauth_data) unless user_signed_in?
    current_user.register_social_profile({ uid: oauth_data.uid, service_name: oauth_data.provider }, twitter_attributes(oauth_data))

    redirect_to root_path
  end

  def twitter_attributes(params)
    {
      consumer_key:        params[:extra][:access_token].consumer.key,
      consumer_secret:     params[:extra][:access_token].consumer.secret,
      access_token:        params[:credentials][:token],
      access_token_secret: params[:credentials][:secret]
    }
  end

  def sign_in_with_oauth_data(data)
    user = User.find_or_create_with_oauth(data)
    sign_in :user, user
  end
end
