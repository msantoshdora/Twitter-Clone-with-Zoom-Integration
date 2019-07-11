class CreateMeetings < ActiveRecord::Migration[5.1]
  def change
    create_table :meetings do |t|
      t.string :title
      t.string :date
      t.string :join_url
      t.references :micropost, foreign_key: true

      t.timestamps
    end
        add_index :meetings, [:micropost_id, :created_at]
  end
end
