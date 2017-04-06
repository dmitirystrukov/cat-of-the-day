class Ability
  include CanCan::Ability

  attr_reader :current_user, :user, :day_subject

  def initialize(current_user, day_subject = nil, user = nil)
    @current_user = current_user

    @day_subject = day_subject
    @user        = user

    grant_permission
  end

  private

  def grant_permission
    return guest_abilities if current_user.blank?

    if current_user.has_role?(:client)
      grant_client_rights
    elsif current_user.has_role?(:consumer)
      grant_consumer_rights
    end
  end

  def grant_client_rights
    can [:read, :create],    DaySubject
    can [:update, :destroy], DaySubject if day_subject.present? && day_subject.owner?(current_user)

    can :read, [:account, :statistic]
    can :read, User

    cannot :create, :social_publication
  end

  def grant_consumer_rights
    can :read, :all
    can :create, SocialPost
    can :create, :social_publication

    can [:edit, :update], User if profile_owner?

    cannot :read, [:account, :statistic]
  end

  def guest_abilities
    can :read, DaySubject
  end

  private

  def profile_owner?
    current_user == user
  end
end
