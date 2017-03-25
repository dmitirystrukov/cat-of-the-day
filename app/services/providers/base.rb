module Providers
  class Base
    attr_reader :client

    private

    def image_file(image_id)
      File.new(DaySubjectImage.find(image_id).url.path)
    end
  end
end
