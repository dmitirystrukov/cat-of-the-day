module ApplicationHelper
  def sign_in?
    current_user.present?
  end
end
