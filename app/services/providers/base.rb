module Providers
  class Base
    def client
      raise NotImplementedError
    end

    private

    def image_file(image_id)
      File.new(DaySubjectImage.find(image_id).url.path)
    end
  end
end
