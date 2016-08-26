module StatisticHelper
  def posts_total(posts, service_name)
    posts.count{ |post| post[:service_name] == service_name }
  end
end
