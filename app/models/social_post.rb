class SocialPost < ActiveRecord::Base
  belongs_to :user

  scope :owner_posts, -> (user_id) { where(user_id: user_id) }
end
