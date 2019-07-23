class CreateGroupthreadmessages < ActiveRecord::Migration[5.2]
  def change
    create_table :groupthreadmessages do |t|
      t.string :message
      t.integer :groupmessage_id
      t.integer :user_id
      t.references :groupmessage, foreign_key: true

      t.timestamps
    end
  end
end
