class SocialPublicationsController < ApplicationController
  authorize_resource class: false

  include ProviderTool

  respond_to :js
  layout false

  before_action :proccess_validation!

  rescue_from ProviderValidationError, with: :provider_authorize_error

  def create
    @social_post = current_user.public_send(provider_collection_name).new(social_post_params)

    if @social_post.valid?
      provider = SocialProvider.new(profile_data, social_post_params[:service_name])
      post = provider.client.update_with_image(social_post_params[:message], day_subject_image)

      @social_post.post_id = get_post_id(post)
      @social_post.url = provider.client.url(@social_post.post_id)

      @social_post.save
    end

    respond_with @social_post
  end

  private

  def day_subject_image
    @day_subject_image ||= DaySubjectImage.find(social_post_params[:day_subject_image_id])
  end

  def day_subject
    @day_subject ||= DaySubject.find(social_post_params[:day_subject_id])
  end

  def social_post_params
    params.require(:social_post).permit(:message, :service_name, :day_subject_id, :day_subject_image_id)
  end

  def proccess_validation!
    validate_profile_data
    validate_provider_type
    validate_image_exists
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

  def provider_authorize_error
    redirect_to day_subject_path(day_subject), flash: { error: 'Provider validation error' }
  end
end
