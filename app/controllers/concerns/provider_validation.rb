module ProviderValidation
  extend ActiveSupport::Concern

  included do
    def proccess_validation!
      validate_profile_data
      validate_provider_type
      validate_image_exists

    rescue ProviderValidationError
      redirect_to day_subject_path(day_subject), flash: { error: 'Provider validation error' }
    end

    def validate_profile_data
      raise ProviderValidationError if profile_data.nil?
    end

    def validate_provider_type
      raise ProviderValidationError if SocialProvider::PROVIDER_TYPES[provider_type].nil?
    end

    def validate_image_exists
      raise ProviderValidationError if social_post_params[:day_subject_image_id].nil?
    end
  end
end
