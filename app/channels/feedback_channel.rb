class FeedbackChannel < ApplicationCable::Channel
  def subscribed
    task = Task.find_by(id: params[:task_id])
    if task && (task.professor == current_user || task.class_room.students.exists?(id: current_user.id))
      stream_for task
    else
      reject
    end
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
