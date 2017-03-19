class PostStatisticWorker
  include Sidekiq::Worker
  include Sidetiq::Schedulable

  recurrence { minutely(1) }

  def perform
    SocialPost.actively.by_service('TwitterPost').each do |social_post|
      user_data = SocialProvider::USER_DATA_TYPES[social_post.service_name].call(social_post.user)
      provider = SocialProvider::PROVIDER_TYPES[social_post.service_name].new(user_data)

      social_post.inactivate! unless provider.post_exists?(social_post.to_param)
    end
  end
end
