module Providers
  class Base
    attr_reader :client

    protected

    def image_file(day_subject_image)
      if Rails.env.development?
        File.new(day_subject_image.url.path)
      else
        file = open(ActionController::Base.helpers.asset_url(day_subject_image.url))
        File.new(file)
      end
    end
  end
end
