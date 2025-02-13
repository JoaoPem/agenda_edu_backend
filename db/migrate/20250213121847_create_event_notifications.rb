class CreateEventNotifications < ActiveRecord::Migration[8.0]
  def change
    create_table :event_notifications do |t|
      t.references :event, null: false, foreign_key: true
      t.references :parent, null: false, foreign_key: { to_table: :users }
      t.text :message, null: false
      t.timestamps
    end
  end
end
