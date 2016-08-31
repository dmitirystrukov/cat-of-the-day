class TwitterService
  def initialize(data)
    @data = data
    @client ||= Twitter::REST::Client.new(@data)
  end

  def update_with_images(social_params, user)
    image_ids = []

    social_params[:urls].each do |image|
      file = File.new("#{Dir.pwd}/public#{image}")

      image_ids << @client.upload(file)
    end

    post = @client.update(social_params[:message], media_ids: image_ids.join(','))

    user.social_posts.create(post_id: post.id, day_subject_id: social_params[:day_subject_id], service_name: self.class)
  end

  def favorite_count(tweet_id)
    @client.status(tweet_id).favorite_count
  end

  def retweet_count(tweet_id)
    @client.status(tweet_id).retweet_count
  end
end
