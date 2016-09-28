module StatisticHelper
  def posts_total(posts, service_name)
    posts.count { |post| post[:service_name] == service_name }
  end

  def likes_total(posts, service_name)
    posts.inject(0) { |total, post| total += post[:likes] if post[:service_name] == service_name }
  end

  def reposts_total(posts, service_name)
    posts.inject(0) { |total, post| total += post[:reposts] if post[:service_name] == service_name }
  end
end
