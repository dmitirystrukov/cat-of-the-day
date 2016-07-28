class DaySubject < ActiveRecord::Base
  belongs_to :user
  has_one :statistics

  validates :name, presence: true, length: { maximum: 30 }
  validates :description, presence: true, length: { maximum: 50 }
end
