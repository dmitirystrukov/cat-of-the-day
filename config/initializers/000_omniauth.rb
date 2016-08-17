Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook,  OmniauthConfig['facebook']['token'],  OmniauthConfig['facebook']['key']
  provider :twitter,   OmniauthConfig['twitter']['token'],   OmniauthConfig['twitter']['key']
  provider :vkontakte, OmniauthConfig['vkontakte']['token'], OmniauthConfig['vkontakte']['key']
end
