module StatisticHelper
  def posts_total(posts, service_name)
    posts.count { |post| post[:service_name] == service_name }
  end

  def likes_total(posts, service_name)
    total = 0

    posts.each { |post| total += post[:likes] if post[:service_name] == service_name }

    total
  end
end
