class User < ActiveRecord::Base
  include Omniauthable

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, omniauth_providers: [:facebook, :vkontakte]

  rolify

  SOCIAL_PROVIDERS = %w(facebook vkontakte).freeze

  has_one  :profile
  has_many :day_subjects
  has_many :social_profiles, dependent: :destroy

  accepts_nested_attributes_for :profile, update_only: true
  delegate :first_name, :last_name, to: :profile, allow_nil: true

  def full_name
    "#{first_name} #{last_name}"
  end

  def social_profile_exist?(name)
    social_profiles.where(service_name: name).any?
  end

  def client?
    has_role? :client
  end
end
