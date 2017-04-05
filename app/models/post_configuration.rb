class PostConfiguration
  include ActiveModel::Model

  attr_accessor :reposts_count, :likes_count, :comments_count
end
