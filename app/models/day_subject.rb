class DaySubject < ActiveRecord::Base
  belongs_to :user
  has_one :image, as: :object

  validates :title, length: { maximum: 40 }

  def owner?(user)
    user_id == user.id
  end
end
