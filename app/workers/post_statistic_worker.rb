class PostStatisticWorker
  include Sidekiq::Worker
  include Sidetiq::Schedulable

  recurrence { minutely(5) }

  def perform
    social_posts = SocialPost.actively

    social_posts.each do |social_post|
      service_name = User::SERVICE_TO_NAME[social_post.service_name]

      service = social_post.service_name.constantize.new(social_post.user.send("#{service_name}_data"))

      social_post.inactivate! unless post_exists?(service, social_post.post_id)
    end
  end

  def entry_exists?(service, post_id)
    service.tweet_status(post_id)
  end
end
