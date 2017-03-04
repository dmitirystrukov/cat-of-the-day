class SocialProvider
  @@provider_service_ending = :Service

  TYPES = {
    :Twitter  => ::TwitterPost.to_s,
    :Facebook => ::FacebookPost.to_s
  }

  PROVIDER_TYPES = {
    'TwitterPost'  => Providers::Twitter,
    'FacebookPost' => Providers::Facebook
  }

  attr_reader :provider_type, :data

  def initialize(data, provider_type)
    @provider_type = provider_type
    @data = data
  end

  def client
    provider = PROVIDER_TYPES[provider_type]
    provider.new(data)
  end

  class << self
    def collect_social_posts(user)
      social_posts = Hash.new

      user.connected_provider_names.each do |provider_name|
        provider_klass = TYPES[provider_name.capitalize.to_sym].constantize
        social_posts[provider_name] = user.public_send(provider_klass.model_name.plural)
      end

      social_posts
    end

    def provider_to_service_name(name)
      "#{name.capitalize}#{@@provider_service_ending}"
    end

    def providers_list
      %w(facebook twitter)
    end
  end
end
