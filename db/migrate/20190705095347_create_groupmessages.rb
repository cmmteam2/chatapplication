class CreateGroupmessages < ActiveRecord::Migration[5.2]
  def change
    create_table :groupmessages do |t|
      t.integer :group_id
      t.string :message
      t.integer :user_id
      t.string :attachment
      t.boolean :unread
      t.boolean :favourite
      t.references :group, foreign_key: true

      t.timestamps
    end
  end
end
