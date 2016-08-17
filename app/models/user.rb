class User < ActiveRecord::Base
  include Omniauthable

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, omniauth_providers: [:facebook, :twitter, :vkontakte]

  rolify

  SOCIAL_PROVIDERS = %w(facebook twitter vkontakte).freeze

  has_one  :profile
  has_many :day_subjects
  has_many :social_profiles, dependent: :destroy

  accepts_nested_attributes_for :profile, update_only: true
  delegate :first_name, :last_name, to: :profile, allow_nil: true

  after_create :init_role

  def init_role
    add_role :consumer
  end

  def full_name
    "#{first_name} #{last_name}"
  end

  def social_profile_exist?(name)
    social_profiles.where(service_name: name).any?
  end

  def twitter_profile
    social_profiles.find_by(service_name: :twitter)
  end

  def twitter_client
    Twitter::REST::Client.new do |config|
      config.consumer_key        = twitter_profile.consumer_key
      config.consumer_secret     = twitter_profile.consumer_secret
      config.access_token        = twitter_profile.access_token
      config.access_token_secret = twitter_profile.access_token_secret
    end
  end

  def client?
    has_role? :client
  end

  def consumer?
    has_role? :consumer
  end
end
