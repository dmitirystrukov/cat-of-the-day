class TwitterService
  def initialize(data)
    @data = data
    @client ||= Twitter::REST::Client.new(@data)
  end

  def update_with_image(social_params, user)
    post = @client.update_with_media(social_params[:message], image_path_by_id(social_params[:image_id]))

    user.social_posts.create(post_id: post.id, message: social_params[:message], day_subject_id: social_params[:day_subject_id],
                             day_subject_image_id: social_params[:image_id], service_name: self.class)
  end

  def image_path_by_id(image_id)
    File.new(DaySubjectImage.find(image_id).url.file.file)
  end

  def favorite_count(tweet_id)
    @client.status(tweet_id).favorite_count
  end

  def retweet_count(tweet_id)
    @client.status(tweet_id).retweet_count
  end

  def tweet_status(tweet_id)
    @client.status(tweet_id)

    rescue Twitter::Error::NotFound
      false
  end
end
