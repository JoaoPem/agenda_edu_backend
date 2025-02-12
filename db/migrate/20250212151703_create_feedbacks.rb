class CreateFeedbacks < ActiveRecord::Migration[8.0]
  def change
    create_table :feedbacks do |t|
      t.references :task, null: false, foreign_key: true
      t.references :student, null: false, foreign_key: { to_table: :users }
      t.text :content, null: false
      t.timestamps
    end
  end
end
