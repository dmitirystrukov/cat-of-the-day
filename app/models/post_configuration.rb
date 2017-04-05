class PostConfiguration
  include ActiveModel::Model

  attr_accessor :reposts_count, :comments_count, :likes_count
end
