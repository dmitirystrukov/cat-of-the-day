class Ability
  include CanCan::Ability

  def initialize(user)
    if user.present?
      user.has_role?(:client) ? client_abilities(user) : user_abilities(user)
    else
      guest_abilities
    end
  end

  def client_abilities(_user)
    can :manage, :all
  end

  def user_abilities(_user)
    can :read, :all
  end

  def guest_abilities
    can :read, :all
  end
end
