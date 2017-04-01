class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def current_namespace
    current_user.present? ? current_user.role.name : :guest
  end

  helper_method :current_namespace

  private

  def current_ability
    Ability.new(current_user)
  end
end
