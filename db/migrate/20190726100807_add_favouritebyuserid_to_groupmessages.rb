class AddFavouritebyuseridToGroupmessages < ActiveRecord::Migration[5.2]
  def change
    add_column :groupmessages, :favouritebyuserid, :integer
  end
end
