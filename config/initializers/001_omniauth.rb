Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook,  OmniauthConfig['facebook']['token'],  OmniauthConfig['facebook']['key'], scope: 'manage_pages user_likes user_photos publish_pages public_profile user_about_me publish_actions'
  provider :twitter,   OmniauthConfig['twitter']['token'],   OmniauthConfig['twitter']['key']
end
