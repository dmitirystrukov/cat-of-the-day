module Omniauthable
  extend ActiveSupport::Concern

  included do
    attr_accessor :social_login

    def self.find_or_create_with_oauth(oauth_data)
      find_with_oauth(oauth_data) || create_with_oauth(oauth_data)
    end

    def self.find_with_oauth(oauth_data)
      find_through_authorization(oauth_data.provider, oauth_data.uid)
    end

    def self.find_through_authorization(service_name, uid)
      social_profile = SocialProfile.find_by(service_name: service_name, uid: uid)
      social_profile.present? ? social_profile.user : nil
    end

    def self.create_with_oauth(oauth_data)
      if oauth_data.size > 2
        first_name, last_name = parse_name(oauth_data)
        user = User.new(profile_attributes: { first_name: first_name, last_name: last_name })
      else
        user = User.new
      end

      user.social_login = true
      user.save!

      user
    end

    def self.parse_name(oauth_data)
      if oauth_data.provider == 'facebook'
        oauth_data.extra.raw_info.name.split(' ')
      end
    end

    def register_social_profile(oauth_data, data)
      social_profile = SocialProfile.find_or_initialize_by(oauth_data)

      social_profile.data = data.to_json
      social_profile.url  = provider(social_profile).client.user_url

      if social_profile.user_id.present?
        return false if social_profile.user_id != id
      else
        social_profile.user_id = id
      end

      social_profile.save

      social_profile.persisted? ? social_profile : false
    end

    def password_required?
      return false if social_login

      super
    end

    def email_required?
      !social_login
    end

    private

    def provider(social_profile)
      SocialProvider.new(social_profile.data, SocialProvider::TYPES[social_profile.service_name.capitalize.to_sym])
    end
  end
end
