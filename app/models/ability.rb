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
      can :manage, Task, professor_id: user.id
    elsif user.student?
      cannot :access, User
      cannot :access, Subject
      cannot :access, Topic
      can [ :show ], ClassRoom, id: user.class_room_id
      cannot :access, Task
      can [ :index, :show, :update ], TaskSubmission, student_id: user.id
      can :create, TaskSubmission
    elsif user.parent?
      can :read, EventNotification, parent_id: user.id
    end
  end
end
