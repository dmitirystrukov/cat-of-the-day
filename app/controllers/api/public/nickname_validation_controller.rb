module Api
  module Public
    class NicknameValidationController < ActionController::Base
      respond_to :json

      def validate
        message = nickname_exists? ? I18n.t('api.public.nickname_validation.failure') : I18n.t('api.public.nickname_validation.success')

        render json: { result: nickname_exists?, message: message }
      end

      private

      def nickname_exists?
        Profile.where(nickname: params[:id]).any?
      end
    end
  end
end
