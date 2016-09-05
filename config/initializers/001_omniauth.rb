Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook,  OmniauthConfig['facebook']['token'],  OmniauthConfig['facebook']['key'], scope: 'manage_pages user_photos publish_pages publish_actions'
  provider :twitter,   OmniauthConfig['twitter']['token'],   OmniauthConfig['twitter']['key']
end
