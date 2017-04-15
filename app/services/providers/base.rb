module Providers
  class Base
    attr_reader :client

    private

    def image_file(image_id)
      day_subject_image = DaySubjectImage.find(image_id)
      image_full_path = helpers.asset_url(day_subject_image.url)

      File.new open(image_full_path)
    end

    def content_type(media_file)
      MimeMagic.by_magic(media_file).type
    end

    def helpers
      ActionController::Base.helpers
    end
  end
end
