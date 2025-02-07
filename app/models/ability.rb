class Ability
  include CanCan::Ability

  def initialize(user)
    return unless user
    if user.admin?
      can :manage, :all
    elsif user.professor?
      cannot :access, User
    elsif user.student?
      cannot :access, User
    end
  end
end
