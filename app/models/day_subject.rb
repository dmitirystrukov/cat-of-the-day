class DaySubject < ActiveRecord::Base
  belongs_to :user
  has_one :image, as: :object, dependent: :destroy

  accepts_nested_attributes_for :image

  validates :title, length: { minimum: 10, maximum: 40 }
  validates :description, length: { minimum: 50, maximum: 500 }

  def owner?(user)
    user_id == user&.id
  end
end
