class SocialPublicationsController < ApplicationController
  include ProviderTool
  include ProviderValidation

  respond_to :js
  layout false

  before_action :proccess_validation!

  def create
    @social_post = current_user.public_send(provider_collection_name).new(social_post_params)

    if @social_post.valid?
      provider = SocialProvider.new(profile_data, social_post_params[:service_name])
      post = provider.client.update_with_image(social_post_params)

      @social_post.post_id = get_post_id(post)
      @social_post.url = provider.client.url(@social_post.post_id)

      @social_post.save
    end

    respond_with @social_post
  end

  private

  def day_subject
    @day_subject ||= DaySubject.find(social_post_params[:day_subject_id])
  end


  def social_post_params
    params.require(:social_post).permit(:message, :service_name, :day_subject_id, :day_subject_image_id)
  end
end
