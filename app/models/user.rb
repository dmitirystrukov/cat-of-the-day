class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_one  :profile
  has_many :day_themes

  accepts_nested_attributes_for :profile, update_only: true
  delegate :first_name, :last_name, to: :profile, allow_nil: true
end
