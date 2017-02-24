module ApplicationHelper
  OWNER_STYLE = {
    class: 'style8',
    image: 'pic10.jpg'
  }

  NOT_OWNER_STYLE = {
    class: 'style2',
    image: 'pic02.jpg'
  }

  def sign_in?
    current_user.present?
  end

  def social_active?(provider)
    current_user.social_profile_exist?(provider) ? 'active' : 'inactively'
  end

  def day_subject_style(day_subject)
    day_subject.owner?(current_user) ? OWNER_STYLE : NOT_OWNER_STYLE
  end

  def record_first?(record, collection)
    record == collection.first
  end
end
