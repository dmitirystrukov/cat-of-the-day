class SocialController < ApplicationController
  def create
    service_name =  User::SERVICE_TO_NAME[social_params[:service]]

    service = social_params[:service].constantize.new(current_user.send("#{service_name}_data"))
    service.update_with_image(social_params, current_user)

    redirect_to :back
  end

  def social_params
    params.require(:social).permit(:message, :service, :day_subject_id, :image)
  end
end
