module Providers
  class Twitter < Base
    attr_accessor :post, :post_id

    def initialize(data)
      @client ||= ::Twitter::REST::Client.new(data)
    end

    attr_reader :client

    def update_with_image(social_params)
      @client.update_with_media(social_params[:message], image_file(social_params[:day_subject_image_id]))
    end

    def post_exists?(id, options={})
      @client.status(id, options)
      true

    rescue ::Twitter::Error::NotFound
      false
    end
  end
end
