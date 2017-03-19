class Ability
  include CanCan::Ability

  attr_reader :user, :day_subject

  def initialize(user, day_subject)
    @user = user
    @day_subject = day_subject

    grant_permission
  end

  private

  def grant_permission
    return guest_abilities if user.blank?

    if user.has_role?(:client)
      grant_client_rights
    elsif user.has_role?(:consumer)
      grant_consumer_rights
    end

  end

  def grant_client_rights
    can [:read, :create], DaySubject
    can [:edit, :destroy], DaySubject if day_subject.present? && day_subject.owner?(user)
  end

  def grant_consumer_rights
    can :read, :all
  end

  def guest_abilities
    can :read, DaySubject
  end
end
