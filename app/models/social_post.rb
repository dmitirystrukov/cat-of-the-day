class SocialPost < ActiveRecord::Base
  belongs_to :user

  scope :owner_posts, -> (user_id) { where(user_id: user_id) }
  scope :actively, -> { where(status: :active) }

  include AASM

  aasm column: :status do
    state :active, initital: true
    state :inactive

    event :activate do
      transitions from: :inactive, to: :active
    end

    event :inactivate do
      transitions from: :active, to: :inactive
    end
  end
end
