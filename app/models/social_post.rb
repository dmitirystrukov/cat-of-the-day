class SocialPost < ActiveRecord::Base
  include AASM

  serialize :data, SocialPostDataCoder

  belongs_to :user
  belongs_to :day_subject

  has_one :day_subject_image, foreign_key: :id, primary_key: :day_subject_image_id

  scope :actively,   -> { where(status: :active) }
  scope :latest,     ->(qnt)          { order(created_at: :desc).limit(qnt) }
  scope :by_service, ->(service_name) { where(service_name: service_name) }

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
