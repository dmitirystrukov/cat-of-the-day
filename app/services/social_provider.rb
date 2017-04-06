# frozen_string_literal: true
class SocialProvider
  PROVIDER_SERVICE_ENDING = :Service
  PER_PAGE = 9

  TYPES = {
    Twitter:  ::TwitterPost.to_s,
    Facebook: ::FacebookPost.to_s
  }.freeze

  PROVIDER_TYPES = {
    'TwitterPost'  => Providers::Twitter,
    'FacebookPost' => Providers::Facebook
  }.freeze

  USER_DATA_TYPES = {
    'TwitterPost'  => ->(user) { user.twitter_post_data },
    'FacebookPost' => ->(user) { user.facebook_post_data }
  }.freeze

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
    def collect_social_posts(model, params, day_subject_id=nil)
      social_posts = {}

      provider_names = if params[:provider_name].present?
                         [params[:provider_name]]
                       else
                         model.connected_provider_names
                       end

      provider_names.each do |provider_name|
        provider_klass = TYPES[provider_name.capitalize.to_sym].constantize

        social_posts[provider_name] = model.public_send(provider_klass.model_name.plural)
        social_posts[provider_name] = social_posts[provider_name].where(day_subject_id: day_subject_id) if day_subject_id.present?

        page = params[:twitter_page].present? ? params[:twitter_page] : params[:facebook_page]

        social_posts[provider_name] = social_posts[provider_name].actively.includes(:day_subject_image, :user).page(page).per(PER_PAGE)
      end

      social_posts
    end

    def providers_list
      %w(facebook twitter)
    end
  end
end
