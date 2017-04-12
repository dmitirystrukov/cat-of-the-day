module Providers
  class Base
    attr_reader :client

    private

    def image_file(image_id)
      tmp_file = open(DaySubjectImage.find(image_id).url.path)

      File.new(tmp_file)
    end
  end
end
