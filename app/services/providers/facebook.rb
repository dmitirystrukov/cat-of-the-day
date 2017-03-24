module Providers
  class Facebook < Base
    def initialize(data)
      @client ||= Koala::Facebook::API.new(data['token'])
    end

    def update_with_image(social_params)
      @client.put_picture(image_file(social_params[:day_subject_image_id]), message: social_params[:message])
    end

    def post_exists?(id, options={})
      @client.get_object(id)
      true

      rescue Koala::Facebook::ClientError
        false
    end

    # TODO Need to implement
    def url(post_id)
      'hardcoded'
    end
  end
end
