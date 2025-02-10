class CreateTaskSubmissions < ActiveRecord::Migration[8.0]
  def change
    create_table :task_submissions do |t|
      t.references :student, null: false, foreign_key:  { to_table: :users }
      t.references :task, null: false, foreign_key: true
      t.string :description

      t.timestamps
    end
  end
end
