class User < ActiveRecord::Base
  include Omniauthable

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, omniauth_providers: SocialProvider.providers_list

  rolify

  SOCIAL_PROVIDERS = %w(facebook twitter).freeze

  SERVICE_TO_NAME = {
    'TwitterService'  => 'twitter',
    'FacebookService' => 'facebook'
  }.freeze

  has_one :profile
  has_one :users_role
  has_one :role, through: :users_role

  has_many :day_subjects

  has_many :social_posts
  has_many :facebook_posts
  has_many :twitter_posts

  has_many :social_profiles, dependent: :destroy

  accepts_nested_attributes_for :profile, update_only: true
  delegate :first_name, :last_name, to: :profile, allow_nil: true

  def full_name
    "#{first_name} #{last_name}"
  end

  def connected_provider_names
    social_profiles.pluck(:service_name)
  end

  def client?
    has_role? :client
  end

  def consumer?
    has_role? :consumer
  end

  def twitter_profile
    social_profiles.find_by(service_name: :twitter)
  end

  def facebook_profile
    social_profiles.find_by(service_name: :facebook)
  end

  def twitter_post_data
    twitter_profile.try(:data)
  end

  def facebook_post_data
    facebook_profile.try(:data)
  end

  def social_profile_exist?(name)
    social_profiles.where(service_name: name).any?
  end
end
