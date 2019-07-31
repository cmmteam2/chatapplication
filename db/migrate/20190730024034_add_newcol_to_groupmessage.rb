class AddNewcolToGroupmessage < ActiveRecord::Migration[5.2]
  def change
    add_column :groupmessages, :newcol, :string, limit: 1000, after: 'group_id'
  end
end
