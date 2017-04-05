module ApplicationHelper
  STATISTIC_FIELD_ICONS = {
    'likes_count'    => 'fa fa-heart',
    'reposts_count'  => 'fa fa-retweet',
    'comments_count' => 'fa fa-comments-o'
  }

  def provider_active_class(provider_name)
    provider_active?(provider_name) ? 'active' : ''
  end

  def provider_active?(provider_name)
    current_user.social_profiles.any? { |profile| profile.service_name == provider_name }
  end

  def tab_active_class(record, collection = SocialProvider.providers_list)
    record_first?(record, collection) ? 'active' : ''
  end

  def record_first?(record, collection)
    record == collection.first
  end

  def profile_owner?(user)
    current_user == user
  end

  def post_statistic_fields(data)
    data.instance_values.map do |key, value|
      post_field(value, STATISTIC_FIELD_ICONS[key])
    end
  end

  def post_field(value, icon_class)
    content_tag :i, class: icon_class do
      concat content_tag :span, "#{value}".html_safe
    end
  end
end
