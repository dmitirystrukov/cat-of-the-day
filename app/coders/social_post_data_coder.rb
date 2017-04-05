class SocialPostDataCoder
  def self.dump(social_post_data)
    social_post_data.serializable_hash.to_json
  end

  def self.load(hash)
    PostConfiguration.new(hash)
  end
end
