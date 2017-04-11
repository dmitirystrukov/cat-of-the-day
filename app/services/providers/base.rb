module Providers
  class Base
    attr_reader :client

    private

    def image_file(image_id)
      day_subject_image = DaySubjectImage.find(image_id)
      image_full_path = helpers.asset_url(day_subject_image.url)

      File.new open(image_full_path)
    end

    def helpers
      ActionController::Base.helpers
    end
  end
end
