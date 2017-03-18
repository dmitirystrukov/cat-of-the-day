module Providers
  class Twitter < Base
    attr_accessor :post, :post_id

    def initialize(data)
      @client ||= ::Twitter::REST::Client.new(data)
    end

    def client
      @client
    end

    def update_with_image(social_params, user)
      message = social_params[:message]
      image_file = image_file(social_params[:day_subject_image_id])

      @client.update_with_media(message, image_file)
    end
  end
end
