module SocialProvider::ModelHelperMethods
  extend ActiveSupport::Concern

  @@method_names = %w(profile data)

  included do
    SocialProvider.list.zip(@@method_names).each do |provider_name, method_name|
      # Defines User model method for getting social profile by its name
      # User.find(1).facebook_profile
      # => #<SocialProfile
      define_method :"#{provider_name}_#{method_name}" do
        social_profiles.find_by(service_name: provider_name)
      end

      # Defines User model method for getting social profile data by its name
      # User.find(1).facebook_data
      # => { consumer_key: XXXX, consumer_secret: XXXX }
      define_method :"#{provider_name}_#{method_name}" do
        public_send("#{provider_name}_profile").try(:data)
      end

      def social_profile_exist?(name)
        social_profiles.where(service_name: name).any?
      end
    end
  end
end
