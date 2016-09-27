class FacebookService
  def initialize(data)
    @data = data['token']
    @client ||= Koala::Facebook::API.new(@data)
  end

  def update_with_image(social_params, user)
    post = @client.put_picture(image_path_by_id(social_params[:image_id]), { message: social_params[:message] })

    user.social_posts.create(post_id: post['id'],
                             day_subject_id: social_params[:day_subject_id],
                             day_subject_image_id: social_params[:image_id],
                             service_name: self.class)
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
end
