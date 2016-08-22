class TwitterService
  def initialize(data)
    @data = data
  end

  def update_with_images(message, images)
    image_ids = []

    images.each do |image|
      file = File.new("#{Dir.pwd}/public#{image}")

      image_ids << client.upload(file)
    end

    client.update(message, media_ids: image_ids.join(','))
  end

  def client
    @client ||= Twitter::REST::Client.new(@data)
  end
end
