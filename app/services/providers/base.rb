module Providers
  class Base
    def client
      raise NotImplementedError
    end

    private

    def image_file(image_id)
      File.new(DaySubjectImage.find(image_id).url.path)
    end

    def social_post_params(post_id, social_params)
      {
        post_id:              post_id,
        day_subject_id:       social_params[:day_subject_id],
        day_subject_image_id: social_params[:image_id],
        message:              social_params[:message],
        service_name:         self.class
      }
    end
  end
end
