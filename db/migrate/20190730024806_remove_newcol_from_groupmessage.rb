class RemoveNewcolFromGroupmessage < ActiveRecord::Migration[5.2]
  def change
    remove_column :groupmessages, :newcol, :string, limit: 1000
  end
end
