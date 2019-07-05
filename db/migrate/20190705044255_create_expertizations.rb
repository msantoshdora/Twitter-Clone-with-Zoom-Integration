class CreateExpertizations < ActiveRecord::Migration[5.1]
  def change
    create_table :expertizations do |t|
      t.integer :user_id
      t.integer :topic_id

      t.timestamps
    end
    add_index :expertizations, :user_id
    add_index :expertizations, :topic_id
    add_index :expertizations, [:user_id, :topic_id], unique: true
  end
end
