class CreateTopics < ActiveRecord::Migration[8.0]
  def change
    create_table :topics do |t|
      t.string :name, null: false
      t.references :subject, null: false, foreign_key: true

      t.timestamps
    end
    add_index :topics, :name, unique: true
  end
end
