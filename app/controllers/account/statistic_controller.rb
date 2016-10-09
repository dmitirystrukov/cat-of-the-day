class Account::StatisticController < ApplicationController
  before_action :authenticate_user!

  def index
    @social_posts = current_user.social_posts.actively
    @statistic = []

    @social_posts.each do |post|
      data    = current_user.send("#{User::SERVICE_TO_NAME[post.service_name]}_data")
      service = post.service_name.constantize.new(data)

      @statistic << {
        service_name: User::SERVICE_TO_NAME[post.service_name],
        post_id:      post.post_id,
        likes:        service.favorite_count(post.post_id)
      }
    end
  end
end
