module Api
  module Public
    class NicknameValidationController < ActionController::Base
      respond_to :json

      def validate
        message = nickname_exists? ? t('.failure') : t('.success')

        render json: { result: nickname_exists?, message: message }
      end

      private

      def nickname_exists?
        Profile.where(nickname: params[:id]).any?
      end
    end
  end
end
