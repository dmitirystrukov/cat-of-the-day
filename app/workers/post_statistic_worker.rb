class PostStatisticWorker
  include Sidekiq::Worker
  include Sidetiq::Schedulable

  POST_DATA = {
    'TwitterPost'  => ->(provider, post_id) { new.tweet_post_data(provider, post_id) },
    'FacebookPost' => ->(provider, post_id) { new.facebook_post_data(provider, post_id) }
  }.freeze

  recurrence { minutely(1) }

  def perform
    PostStatusWorker.new.perform

    SocialPost.actively.each do |social_post|
      user_data = SocialProvider::USER_DATA_TYPES[social_post.service_name].call(social_post.user)
      provider =  SocialProvider::PROVIDER_TYPES[social_post.service_name].new(user_data)

      social_post.update(data: POST_DATA[social_post.service_name].call(provider, social_post.post_id).to_json)
    end
  end

  def tweet_post_data(provider, post_id)
    PostConfiguration.new(reposts_count: provider.reposts_count(post_id),
                          likes_count: provider.likes_count(post_id))
  end

  def facebook_post_data(provider, post_id)
    PostConfiguration.new(comments_count: provider.comments_count(post_id),
                          likes_count:  provider.likes_count(post_id))
  end
end
