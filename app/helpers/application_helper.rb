module ApplicationHelper
  def day_subject_show_path(day_subject)
    # return guest_day_subject_path(day_subject) if current_user.blank?

    # case current_user.role.name.to_sym
    # when :client
    #   client_day_subject_path(day_subject)
    # when :consumer
      consumer_day_subject_path(day_subject)
    # end
  end

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
end
