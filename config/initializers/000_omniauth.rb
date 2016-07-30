Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, OmniauthConfig['facebook']['token'], OmniauthConfig['facebook']['key']
end
