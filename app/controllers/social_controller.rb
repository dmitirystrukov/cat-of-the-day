class SocialController < ApplicationController
  before_action :verify_permission!, if: -> { [social_params[:service].empty?, service_plugged?(social_params[:service])] }

  def create
    service_name =  User::SERVICE_TO_NAME[social_params[:service]]

    service = social_params[:service].constantize.new(current_user.send("#{service_name}_data"))
    service.update_with_image(social_params, current_user)

    redirect_to :back
  end

  private

  def verify_permission!
    redirect_to day_subject_path(social_params[:day_subject_id]), flash: { error: 'You not choose service or not plugged it ' }
  end

  def service_plugged?(service_name)
    return if service_name.empty?

    current_user.send("#{User::SERVICE_TO_NAME[service_name]}_profile").nil?
  end

  def social_params
    params.require(:social).permit(:message, :service, :day_subject_id, :image)
  end
end
