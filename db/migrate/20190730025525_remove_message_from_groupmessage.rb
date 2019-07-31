class RemoveMessageFromGroupmessage < ActiveRecord::Migration[5.2]
  def change
    remove_column :groupmessages, :message, :string
  end
end
