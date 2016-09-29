class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new

    if user.admin?
      can :manage, :all
    else
      can :read, :all
    end

    can :manage, Game do |game|
      game.user == user
    end
  end
end
