class PostConfiguration
  include ActiveModel::Model

  attr_accessor :reposts_count, :comments_count, :likes_count

  def tweet_data(provider, post_id)
    new(reposts_count: provider.reposts_count(post_id),
        likes_count:   provider.likes_count(post_id))
  end

  def facebook_data(provider, post_id)
    new(comments_count: provider.comments_count(post_id),
        likes_count:    provider.likes_count(post_id))
  end
end
