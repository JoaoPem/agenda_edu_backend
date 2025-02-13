class CreateEvents < ActiveRecord::Migration[8.0]
  def change
    create_table :events do |t|
      t.string :title, null: false
      t.text :description, null: false
      t.datetime :event_date, null: false
      t.references :class_room, null: false, foreign_key: true
      t.timestamps
    end
  end
end
