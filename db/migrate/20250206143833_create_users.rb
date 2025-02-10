class CreateUsers < ActiveRecord::Migration[8.0]
  def change
    create_table :users do |t|
      t.string :name, null: false
      t.string :email, null: false
      t.string :password_digest, null: false
      t.integer :role, null: false, default: 2
      t.references :class_room, foreign_key: true, null: true
      t.timestamps
    end
    add_index :users, :email, unique: true
  end
end
