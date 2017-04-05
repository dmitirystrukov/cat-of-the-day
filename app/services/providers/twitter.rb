module Providers
  class Twitter < Base
    def initialize(data)
      @client ||= ::Twitter::REST::Client.new(data)
    end

    def update_with_image(social_params)
      @client.update_with_media(social_params[:message], image_file(social_params[:day_subject_image_id]))
    end

    def post_exists?(id, options={})
      @client.status(id, options)
      true

    rescue ::Twitter::Error::NotFound
      false
    end

    def url(post_id)
      @client.status(post_id).url.to_s
    end

    def user_url
      @client.user.url.to_s
    end

    def likes_count(post_id)
      @client.status(post_id).favorite_count
    end

    def reposts_count(post_id)
      @client.status(post_id).retweet_count
    end
  end
end
