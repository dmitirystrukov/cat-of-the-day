class User < ActiveRecord::Base
  include Omniauthable
  include SocialProvider::ModelHelperMethods

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, omniauth_providers: SocialProvider.list

  rolify

  SOCIAL_PROVIDERS = %w(facebook twitter).freeze

  SERVICE_TO_NAME = {
    'TwitterService'  => 'twitter',
    'FacebookService' => 'facebook'
  }.freeze

  has_one  :profile
  has_many :day_subjects
  has_many :social_posts
  has_many :social_profiles, dependent: :destroy

  accepts_nested_attributes_for :profile, update_only: true
  delegate :first_name, :last_name, to: :profile, allow_nil: true

  def full_name
    "#{first_name} #{last_name}"
  end

  def client?
    has_role? :client
  end

  def consumer?
    has_role? :consumer
  end
end
