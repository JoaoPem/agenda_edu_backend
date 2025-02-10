class CreateTasks < ActiveRecord::Migration[8.0]
  def change
    create_table :tasks do |t|
      t.string :title, null: false
      t.text :description, null: false
      t.datetime :deadline, null: false
      t.references :class_room, null: false, foreign_key: true
      t.references :subject, null: false, foreign_key: true
      t.references :topic, null: false, foreign_key: true
      t.references :professor, null: false, foreign_key: { to_table: :users }

      t.timestamps
    end
  end
end
