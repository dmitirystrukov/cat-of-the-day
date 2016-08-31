class SocialController < ApplicationController
  def create
    service = social_params[:service].constantize.new(current_user.twitter_data)
    service.update_with_images(social_params, current_user)

    redirect_to :back
  end

  def social_params
    params.require(:social).permit(:message, :service, :day_subject_id, urls: [])
  end
end
