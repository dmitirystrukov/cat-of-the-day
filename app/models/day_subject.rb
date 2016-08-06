class DaySubject < ActiveRecord::Base
  # scope :user_day_subjects, -> (user) { }

  belongs_to :user
  has_many :images, as: :object, dependent: :destroy

  accepts_nested_attributes_for :images

  validates :title, length: { minimum: 10, maximum: 40 }
  validates :description, length: { minimum: 50, maximum: 500 }

  mount_uploaders :images, DaySubjectImageUploader

  def owner?(user)
    user_id == user&.id
  end
end
