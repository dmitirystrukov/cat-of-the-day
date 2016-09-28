module ApplicationHelper
  def sign_in?
    current_user.present?
  end

  def social_active?(provider)
    current_user.social_profile_exist?(provider) ? 'active' : 'inactively'
  end
end
