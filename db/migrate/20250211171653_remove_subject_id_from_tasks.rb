class RemoveSubjectIdFromTasks < ActiveRecord::Migration[8.0]
  def change
    remove_column :tasks, :subject_id, :bigint
  end
end
