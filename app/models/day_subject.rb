class DaySubject < ActiveRecord::Base
  belongs_to :user
  has_one :image, as: :object

  def owner?(user)
    self.user_id == user.id
  end
end
