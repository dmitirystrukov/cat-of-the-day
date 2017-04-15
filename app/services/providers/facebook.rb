module Providers
  class Facebook < Base
    def initialize(data)
      @client ||= Koala::Facebook::API.new(data['token'])
    end

    def update_with_image(social_params)
      media_file = image_file(social_params[:day_subject_image_id])

      @client.put_picture(media_file, content_type(media_file), { message: social_params[:message] })
    end

    def post_exists?(post_id, _options={})
      @client.get_object(post_id)
      true

    rescue Koala::Facebook::ClientError
      false
    end

    def url(post_id)
      @client.get_object(post_id, fields: 'permalink_url')['permalink_url']
    end

    def user_url
      @client.get_object('me', fields: 'link')['link']
    end

    def likes_count(post_id)
      @client.get_object(post_id, fields: 'likes.summary(true)')['likes']['summary']['total_count']
    end

    def comments_count(post_id)
      @client.get_object(post_id, fields: 'comments.summary(true)')['comments']['summary']['total_count']
    end
  end
end
