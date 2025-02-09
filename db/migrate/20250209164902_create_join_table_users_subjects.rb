class CreateJoinTableUsersSubjects < ActiveRecord::Migration[8.0]
  def change
    create_join_table :users, :subjects do |t|
      t.index [ :user_id, :subject_id ]
      t.index [ :subject_id, :user_id ]
    end
  end
end
