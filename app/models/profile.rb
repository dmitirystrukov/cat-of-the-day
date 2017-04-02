class Profile < ActiveRecord::Base
  extend FriendlyId

  friendly_id :nickname, use: :slugged

  belongs_to :user

  validates :first_name, :nickname, presence: true
end
