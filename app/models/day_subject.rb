class DaySubject < ActiveRecord::Base
  attr_accessor :style_class, :style_image

  belongs_to :user

  has_many :social_posts
  has_many :twitter_posts
  has_many :facebook_posts

  has_many :day_subject_images, dependent: :destroy

  validates :title,       length: { minimum: 10, maximum: 40 }
  validates :description, length: { minimum: 50, maximum: 500 }

  accepts_nested_attributes_for :day_subject_images

  def connected_provider_names
    social_posts.actively.pluck(:service_name).uniq.map do |service_name|
      provider = SocialProvider::PROVIDER_TYPES[service_name]
      provider.name.demodulize.downcase
    end
  end

  def owner?(user)
    user_id == user&.id
  end

  def images
    day_subject_images
  end
end
