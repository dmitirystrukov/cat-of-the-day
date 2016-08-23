class TwitterService
  def initialize(data)
    @data = data
  end

  def update_with_images(message, images, user)
    image_ids = []

    images.each do |image|
      file = File.new("#{Dir.pwd}/public#{image}")

      image_ids << client.upload(file)
    end

    post = client.update(message, media_ids: image_ids.join(','))

    user.social_posts.create(post_id: post.id)
  end

  def favorite_count(tweet_id)
    @client.status(tweet_id).favorite_count
  end

  def client
    @client ||= Twitter::REST::Client.new(@data)
  end
end
