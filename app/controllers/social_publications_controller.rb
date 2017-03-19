class SocialPublicationsController < ApplicationController
  respond_to :js
  layout false

  def create
    @social_post = current_user.public_send(provider_collection_name).new(social_post_params)

    if @social_post.valid?
      provider = SocialProvider.new(data, social_post_params[:service_name])
      post = provider.client.update_with_image(social_post_params, current_user)

      @social_post.post_id = post_id(post, @social_post.service_name)
      @social_post.save
    end

    respond_with @social_post
  end

  private

  def provider_collection_name
    social_post_params[:service_name].classify.constantize.model_name.plural
  end

  def post_id(post, type)
    providers = {
      'FacebookPost' => -> (post) { post['post_id'] },
      'TwitterPost'  => -> (post) { post.id }
    }

    providers[type].call(post)
  end

  def day_subject
    @day_subject ||= DaySubject.find(social_post_params[:day_subject_id])
  end

  def data
    current_user.public_send("#{@social_post.service_name.underscore}_data")
  end

  def verify_permission!
    # return unless service_plugged?(social_params[:service])
    #
    # redirect_to day_subject_path(social_params[:day_subject_id]), flash: { error: 'You not choose service or not plugged it ' }
  end

  def service_plugged?(service_name)
    # return if service_name.empty?
    #
    # current_user.send("#{User::SERVICE_TO_NAME[service_name]}_profile").nil?
  end

  def social_post_params
    params.require(:social_post ).permit(:message, :service_name, :day_subject_id, :day_subject_image_id)
  end
end
