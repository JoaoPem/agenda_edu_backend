class CreateTaskStatuses < ActiveRecord::Migration[8.0]
  def change
    create_table :task_statuses do |t|
      t.references :student, null: false, foreign_key: { to_table: :users }
      t.references :task, null: false, foreign_key: true
      t.integer :status, default: 0, null: false

      t.timestamps
    end
  end
end
