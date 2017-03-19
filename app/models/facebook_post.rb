class FacebookPost < SocialPost
  default_scope { where(service_name: 'FacebookPost') }

  def service_name_humanized
    'Facebook'
  end
end
