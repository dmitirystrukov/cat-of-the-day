class TwitterPost < SocialPost
  default_scope { where(service_name: 'TwitterPost') }

  validates :message, length: { maximum: 140 }

  def service_name_humanized
    'Twitter'
  end
end
