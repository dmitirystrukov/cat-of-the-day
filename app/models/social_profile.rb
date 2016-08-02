class SocialProfile < ActiveRecord::Base
  belongs_to :user

  validates :service_name, :uid, presence: true
  validates :service_name, uniqueness: { scope: :user_id }

  def self.owner_by_unique_id(id)
    find_by(uid: id)&.user
  end
end
