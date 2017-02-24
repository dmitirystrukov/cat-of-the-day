class DaySubject < ActiveRecord::Base
  belongs_to :user
  has_many :day_subject_images, dependent: :destroy

  validates :title,       length: { minimum: 10, maximum: 40 }
  validates :description, length: { minimum: 50, maximum: 500 }

  accepts_nested_attributes_for :day_subject_images

  def images
    day_subject_images
  end

  def owner?(user)
    user_id == user&.id
  end
end
