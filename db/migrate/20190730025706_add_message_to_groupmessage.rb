class AddMessageToGroupmessage < ActiveRecord::Migration[5.2]
  def change
    add_column :groupmessages, :message, :string, limit: 1000, after: 'group_id'
  end
end
