class CreateClassRooms < ActiveRecord::Migration[8.0]
  def change
    create_table :class_rooms do |t|
      t.string :name, null: false

      t.timestamps
    end
    add_index :class_rooms, :name, unique: true
  end
end
