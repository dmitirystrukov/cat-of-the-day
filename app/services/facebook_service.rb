class FacebookService
  def initialize(data)
    @data = data['token']
    @client ||= Koala::Facebook::API.new(@data)
  end

  def update_with_image(social_params, user)
    file = File.new("#{Dir.pwd}/public#{social_params[:image]}")
    post = @client.put_picture(file, { message: social_params[:message] })

    user.social_posts.create(post_id: post['id'], day_subject_id: social_params[:day_subject_id], service_name: self.class)
  end

  def favorite_count(post_id)
    @client.status(tweet_id).favorite_count
  end

  def retweet_count(post_id)
    @client.status(tweet_id).retweet_count
  end
end
