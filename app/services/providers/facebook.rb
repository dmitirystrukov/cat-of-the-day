module Providers
  class Facebook < Base
    def initialize(data)
      @client ||= Koala::Facebook::API.new(data['token'])
    end

    def update_with_image(social_params)
      @client.put_picture(image_file(social_params[:day_subject_image_id]), message: social_params[:message])
    end

    def post_exists?(post_id, options={})
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
  end
end
