class DaySubjectImage < ActiveRecord::Base
  belongs_to :user
  belongs_to :day_subject

  mount_uploader :url, DaySubjectImageUploader
end
