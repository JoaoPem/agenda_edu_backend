class CreateProfessorsSubjectsJoinTable < ActiveRecord::Migration[8.0]
  def change
    create_table :professors_subjects, id: false do |t|
      t.references :professor, null: false, foreign_key: { to_table: :users }
      t.references :subject, null: false, foreign_key: true
    end

    add_index :professors_subjects, [ :professor_id, :subject_id ], unique: true
  end
end
