module Api
  module Public
    class ProfilesController < ActionController::Base
      def show
        profile = Profile.find_by(nickname: params[:id])

        render json: profile
      end
    end
  end
end
