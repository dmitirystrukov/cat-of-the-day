class TwitterService
  def initialize(data)
    @data = data
    @client ||= Twitter::REST::Client.new(@data)
  end

  def update_with_image(social_params, user)
    file = File.new("#{Dir.pwd}/public#{social_params[:image]}")
    post = @client.update_with_media(social_params[:message], file)

    user.social_posts.create(post_id: post.id, day_subject_id: social_params[:day_subject_id], service_name: self.class)
  end

  def favorite_count(tweet_id)
    @client.status(tweet_id).favorite_count
  end

  def retweet_count(tweet_id)
    @client.status(tweet_id).retweet_count
  end
end
