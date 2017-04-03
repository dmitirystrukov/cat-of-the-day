class PostStatisticWorker
  include Sidekiq::Worker
  include Sidetiq::Schedulable

  recurrence { minutely(1) }

  def perform
    PostStatusWorker.new.perform

    SocialPost.actively.each do |social_post|
      user_data = SocialProvider::USER_DATA_TYPES[social_post.service_name].call(social_post.user)
      provider =  SocialProvider::PROVIDER_TYPES[social_post.service_name].new(user_data)

      likes_count    = provider.likes_count(social_post.post_id)
      comments_count = provider.comments_count(social_post.post_id)

      social_post.update(data: { likes_count: likes_count, comments_count: comments_count })
    end
  end
end
