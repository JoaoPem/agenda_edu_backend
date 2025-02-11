class Ability
  include CanCan::Ability

  def initialize(user)
    return unless user
    if user.admin?
      can :manage, :all
    elsif user.professor?
      cannot :access, User
      can :read, Subject
      can :read, Topic
      can :read, ClassRoom
      can :manage, Task
    elsif user.student?
      cannot :access, User
      cannot :access, Subject
      cannot :access, Topic
      can [ :show ], ClassRoom, id: user.class_room_id
      cannot :access, Task
      can [ :show, :update ], TaskSubmission, student_id: user.id
      can :create, TaskSubmission
    end
  end
end
