module Account
  class UsersController < ApplicationController
    authorize_resource
    respond_to :html

    def show
      @user = User.by_slug(params[:id])
    end

    def update
      current_user.update(user_params)

      respond_with current_user, location: -> { account_user_path(current_user.profile) }
    end

    private

    def current_ability
      Ability.new(current_user, nil, user)
    end

    def user
      @user ||= User.by_slug(params[:id])
    end

    def user_params
      params.require(:user).permit(:email, profile_attributes: [:first_name, :last_name, :location, :website])
    end
  end
end
