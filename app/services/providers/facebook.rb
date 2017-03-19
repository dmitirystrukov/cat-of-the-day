module Providers
  class Facebook < Base
    def initialize(data)
      @client ||= Koala::Facebook::API.new(data['token'])
    end

    def update_with_image(social_params)
      @client.put_picture(image_file(social_params[:day_subject_image_id]), message: social_params[:message])
    end
  end
end
