module SocialProvider
  @@providers_list = %w(facebook twitter)
  @@provider_service_ending = :Service

  class << self
    def collect_social_posts(collection)
      social_posts = Hash.new

      @@providers_list.each do |provider_name|
        provider_service_name = provider_to_service_name(provider_name)
        social_posts[provider_name] = collection.by_service(provider_service_name)
      end

      social_posts
    end

    def provider_to_service_name(name)
      "#{name.capitalize}#{@@provider_service_ending}"
    end

    def list
      @@providers_list
    end
  end
end
