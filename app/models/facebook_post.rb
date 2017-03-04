class FacebookPost < SocialPost
  default_scope { where(service_name: 'FacebookPost') }
end
