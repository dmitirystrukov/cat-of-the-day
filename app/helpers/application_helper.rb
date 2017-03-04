module ApplicationHelper
  def social_active?(provider)
    nil
  end

  def tab_active_class(record, collection = SocialProvider.list)
    record_first?(record, collection) ? 'active' : ''
  end

  def record_first?(record, collection)
    record == collection.first
  end
end
